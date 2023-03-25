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
    func createPolyline()
    func createMapCamera()
    func toggleMenuFlag()
    func manageAnnotation(_ map: MapView)
    func setupCoordinates(_ coordinates: CLLocationCoordinate2D)
    func addViewAnnotation(_ coordinate: CLLocationCoordinate2D)
    func mapMenuLeadingConstraint() -> CGFloat
}
