//
//  PSWMapPresenterProtocol.swift
//  PSW_Test
//
//  Created by Daniil on 25.03.2023.
//

import Foundation
import CoreLocation
import MapboxMaps

/// Протокол презентера карты
protocol PSWMapPresenterProtocol {
    var isMenuShown: Bool { get set }
    var isFocusOn: Bool { get set }
    var currentLogoCoordinate: CLLocationCoordinate2D? { get set }
    var currentFocusMarkerCoordinate: CLLocationCoordinate2D? { get set }
    var annotationManager: PolylineAnnotationManager? { get set }
    func createPolyline()
    func setupCoordinates(_ coordinates: CLLocationCoordinate2D)
    func manageAnnotation(_ map: MapView)
    func createMapCamera()
}
