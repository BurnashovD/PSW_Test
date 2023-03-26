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
    func toggleMenuFlag()
    func createMapCamera()
    func manageAnnotation(_ map: MapView)
    func addViewAnnotation(_ coordinate: CLLocationCoordinate2D)
    func mapMenuLeadingConstraint() -> CGFloat
}
