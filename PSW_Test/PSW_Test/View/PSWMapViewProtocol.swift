//
//  PSWMapViewProtocol.swift
//  PSW_Test
//
//  Created by Daniil on 25.03.2023.
//

import Foundation
import MapboxMaps

/// Протокол вью карты
protocol PSWMapViewProtocol: AnyObject {
    func setCamera(_ camera: CameraOptions)
    func removeAnnotation()
}
