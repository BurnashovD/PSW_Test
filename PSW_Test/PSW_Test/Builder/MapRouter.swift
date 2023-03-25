//
//  MapRouter.swift
//  PSW_Test
//
//  Created by Daniil on 25.03.2023.
//

import UIKit

final class MapRouter: Routable {
    
    private var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func initialVC() {
        let mapModul = MapModulBuilder.build(navController: navigationController)
        navigationController.pushViewController(mapModul, animated: true)
    }
}
