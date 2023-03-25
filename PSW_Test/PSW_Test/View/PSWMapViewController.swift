//
//  ViewController.swift
//  PSW_Test
//
//  Created by Daniil on 25.03.2023.
//

import UIKit
import MapboxMaps

/// Карта PSW
final class PSWMapViewController: UIViewController {
    // MARK: - Visual components
    
    private let pswMap: MapView = {
        let resouceOptions = ResourceOptions(accessToken: "sk.eyJ1IjoiYnVybmFzaG92IiwiYSI6ImNsZm1wMGczczBkZmQzcW1tanhnbDJkYmYifQ.0TCZKhkN_XpvloOrLsIIgA")
        let camera = CameraOptions(center: CLLocationCoordinate2D(latitude: 55.754219, longitude: 37.624392), zoom: 10)
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
    
    private var mapMenuLeadingConstraint = NSLayoutConstraint()
    
    // MARK: - Private properties
    
    var presenter: PSWMapPresenterProtocol?
    
    // MARK: - Public methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        createMapAnchors()
        createMapMenuViewAnchors()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        view.addSubview(pswMap)
        view.addSubview(mapMenuView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                            target: self,
                                                            action: #selector(showHideSettingsMenuAction))
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
        mapMenuLeadingConstraint = mapMenuView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 400)
        NSLayoutConstraint.activate([
            mapMenuView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            mapMenuView.heightAnchor.constraint(equalToConstant: 90),
            mapMenuView.widthAnchor.constraint(equalToConstant: 350),
            mapMenuLeadingConstraint
        ])
    }
    
    @objc private func showHideSettingsMenuAction() {
        guard
            var presenter = presenter
        else { return }
        mapMenuLeadingConstraint.constant = presenter.isMenuShown ? 400 : 0
        UIView.animate(withDuration: 0.5) {
            self.mapMenuView.superview?.layoutIfNeeded()
        }
        presenter.isMenuShown.toggle()
    }
}

extension PSWMapViewController: PSWMapViewProtocol {
    
}
