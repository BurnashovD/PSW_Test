//
//  PSWMapPresenter.swift
//  PSW_Test
//
//  Created by Daniil on 25.03.2023.
//

import Foundation
import CoreLocation
import MapboxMaps

/// Презентер карты
final class PSWMapPresenter: PSWMapPresenterProtocol {
    // MARK: - Private properties
    
    private weak var view: PSWMapViewProtocol?
    private var router: Routable
    private var isFocusOn = false
    private var isMenuShown = false
    private var currentLogoCoordinate: CLLocationCoordinate2D?
    private var currentFocusMarkerCoordinate: CLLocationCoordinate2D?
    private var annotationManager: PolylineAnnotationManager?
    
    // MARK: - init
    
    init(view: PSWMapViewProtocol?, router: Routable) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Public methods
    
    func manageAnnotation(_ map: MapView) {
        isFocusOn.toggle()
        annotationManager = map.annotations.makePolylineAnnotationManager(id: Constants.annotationManagerId)
        currentFocusMarkerCoordinate = nil
        view?.removeAnnotation()
    }
    
    func createMapCamera() {
        guard
            let latitude = currentLogoCoordinate?.latitude,
            let longitude = currentLogoCoordinate?.longitude
        else { return }
        let camera = CameraOptions(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), zoom: 13)
        view?.setCamera(camera)
    }
    
    func addViewAnnotation(_ coordinate: CLLocationCoordinate2D) {
        setupCoordinates(coordinate)
        let options = ViewAnnotationOptions(geometry: Point(coordinate), allowOverlap: true, anchor: .center)
        view?.createAnnotation(isFocusOn: isFocusOn, options: options)
        createPolyline()
    }
    
    func mapMenuLeadingConstraint() -> CGFloat {
        isMenuShown ? Constants.hiddenMenuLeadingConstraint : Constants.shownMenuLeadingConstraint
    }
    
    func toggleMenuFlag() {
        isMenuShown.toggle()
    }
    
    // MARK: - Private methods
    
    private func createPolyline() {
        guard
            let firstCoordinate = currentLogoCoordinate,
            let secondCoordinate = currentFocusMarkerCoordinate
        else { return }
        let coordinates = [firstCoordinate, secondCoordinate]
        var polyline = PolylineAnnotation(lineCoordinates: coordinates)
        polyline.lineWidth = 2
        annotationManager?.annotations = [polyline]
    }
    
    private func setupCoordinates(_ coordinates: CLLocationCoordinate2D) {
        guard isFocusOn else {
            currentLogoCoordinate = coordinates
            return
        }
        currentFocusMarkerCoordinate = coordinates
    }
}

/// Константы
private extension PSWMapPresenter {
    enum Constants {
        static let annotationManagerId = "psw"
        static let hiddenMenuLeadingConstraint: CGFloat = 400
        static let shownMenuLeadingConstraint: CGFloat = 0
    }
}
