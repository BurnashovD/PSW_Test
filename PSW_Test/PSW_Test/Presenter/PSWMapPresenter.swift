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
    // MARK: - Public properties
    
    var isMenuShown = false
    var isFocusOn = false
    var currentLogoCoordinate: CLLocationCoordinate2D?
    var currentFocusMarkerCoordinate: CLLocationCoordinate2D?
    var annotationManager: PolylineAnnotationManager?
    
    // MARK: - Private properties
    
    private weak var view: PSWMapViewProtocol?
    private var router: Routable
    
    // MARK: - init
    
    init(view: PSWMapViewProtocol?, router: Routable) {
        self.view = view
        self.router = router
    }
    
    // MARK: - Public methods
    
    func createPolyline() {
        guard
            let firstCoordinate = currentLogoCoordinate,
            let secondCoordinate = currentFocusMarkerCoordinate
        else { return }
        let coordinates = [firstCoordinate, secondCoordinate]
        var polyline = PolylineAnnotation(lineCoordinates: coordinates)
        polyline.lineWidth = 2
        annotationManager?.annotations = [polyline]
    }
    
    func setupCoordinates(_ coordinates: CLLocationCoordinate2D) {
        guard isFocusOn else {
            currentLogoCoordinate = coordinates
            return
        }
        currentFocusMarkerCoordinate = coordinates
    }
    
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
}

/// Константы
private extension PSWMapPresenter {
    enum Constants {
        static let annotationManagerId = "psw"
    }
}
