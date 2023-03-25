//
//  MapModulBuilder.swift
//  PSW_Test
//
//  Created by Daniil on 25.03.2023.
//

import UIKit

enum MapModulBuilder {
    static func build(navController: UINavigationController) -> UIViewController {
        let view = PSWMapViewController()
        let router = MapRouter(navigationController: navController)
        let presenter = PSWMapPresenter(view: view, router: router)
        view.presenter = presenter
        return view
    }
}
