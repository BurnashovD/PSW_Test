//
//  ViewController.swift
//  PSW_Test
//
//  Created by Daniil on 25.03.2023.
//

import UIKit
import MapboxMaps
import CoreLocation

/// Карта PSW
final class PSWMapViewController: UIViewController {
    // MARK: - Visual components
    
    private let pswMap: MapView = {
        let resouceOptions = ResourceOptions(accessToken: Constants.accessToken)
        let camera = CameraOptions(center: CLLocationCoordinate2D(latitude: Constants.defaultMoscowLatitude, longitude: Constants.defaultMoscowLongitude), zoom: 10)
        let initOptions = MapInitOptions(resourceOptions: resouceOptions, cameraOptions: camera)
        let map = MapView(frame: .zero, mapInitOptions: initOptions)
        map.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    private let mapMenuView: MapMenuView = {
        let view = MapMenuView()
        view.layer.cornerRadius = 20
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let pswLogoImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.pswLogoImageName)
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        image.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        return image
    }()
    
    private let focusMarkerImageView: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: Constants.locatorImageName)
        image.frame = CGRect(x: 0, y: 0, width: 45, height: 45)
        return image
    }()
    
    private let setLogoTapGesture = UITapGestureRecognizer()
    
    private var mapMenuLeadingConstraint = NSLayoutConstraint()
    
    // MARK: - Public properties
    
    var presenter: PSWMapPresenterProtocol?
    
    // MARK: - Public methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
        bindMenu()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        setupLogoGesture()
        view.addSubview(pswMap)
        view.addSubview(mapMenuView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                            target: self,
                                                            action: #selector(showHideSettingsMenuAction))
    }
    
    private func setupLayout() {
        createMapAnchors()
        createMapMenuViewAnchors()
    }
    
    private func setupLogoGesture() {
        setLogoTapGesture.addTarget(self, action: #selector(addLogoOnMapAction(gesture:)))
        pswMap.addGestureRecognizer(setLogoTapGesture)
    }
    
    private func bindMenu() {
        mapMenuView.centerHandler = { [weak self] in
            guard let self = self else { return }
            self.presenter?.createMapCamera()
        }
        
        mapMenuView.focusHandler = { [weak self] in
            guard let self = self else { return }
            self.presenter?.manageAnnotation(self.pswMap)
        }
    }
    
    private func createMapAnchors() {
        NSLayoutConstraint.activate([
            pswMap.topAnchor.constraint(equalTo: view.topAnchor),
            pswMap.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pswMap.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pswMap.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createMapMenuViewAnchors() {
        mapMenuLeadingConstraint = mapMenuView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.hiddenMenuLeadingConstraint)
        NSLayoutConstraint.activate([
            mapMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            mapMenuView.heightAnchor.constraint(equalToConstant: 90),
            mapMenuView.widthAnchor.constraint(equalToConstant: 350),
            mapMenuLeadingConstraint
        ])
    }
    
    @objc private func showHideSettingsMenuAction() {
        guard let presenter = presenter else { return }
        mapMenuLeadingConstraint.constant = presenter.mapMenuLeadingConstraint()
        UIView.animate(withDuration: 0.5) {
            self.mapMenuView.superview?.layoutIfNeeded()
        }
        presenter.toggleMenuFlag()
    }
    
    @objc private func addLogoOnMapAction(gesture: UITapGestureRecognizer) {
        let touchLocation = gesture.location(in: pswMap)
        let coordinate = pswMap.mapboxMap.coordinate(for: touchLocation)
        presenter?.addViewAnnotation(coordinate)
    }
}

/// Реализация протокола вью
extension PSWMapViewController: PSWMapViewProtocol {
    func createAnnotation(isFocusOn: Bool, options: ViewAnnotationOptions) {
        pswMap.viewAnnotations.remove(isFocusOn ? focusMarkerImageView : pswLogoImageView)
        try? self.pswMap.viewAnnotations.add(isFocusOn ? focusMarkerImageView : pswLogoImageView, options: options)
    }
    
    func setCamera(_ camera: CameraOptions) {
        pswMap.camera.ease(to: camera, duration: 0.5)
    }
    
    func removeAnnotation() {
        pswMap.viewAnnotations.remove(focusMarkerImageView)
    }
}

/// Константы
private extension PSWMapViewController {
    enum Constants {
        static let pswLogoImageName = "pswLogo"
        static let locatorImageName = "location"
        static let hiddenMenuLeadingConstraint: CGFloat = 400
        static let shownMenuLeadingConstraint: CGFloat = 0
        static let defaultMoscowLatitude = 55.754219
        static let defaultMoscowLongitude = 37.624392
        static let accessToken = "sk.eyJ1IjoiYnVybmFzaG92IiwiYSI6ImNsZm1wMGczczBkZmQzcW1tanhnbDJkYmYifQ.0TCZKhkN_XpvloOrLsIIgA"
    }
}
