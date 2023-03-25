//
//  MapRouter.swift
//  PSW_Test
//
//  Created by Daniil on 25.03.2023.
//

import UIKit

/// Роутер карты
final class MapRouter: Routable {
    // MARK: - Visual components
    
    private var navigationController: UINavigationController
    
    // MARK: - init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    
    func initialVC() {
        let mapModul = MapModulBuilder.build(navController: navigationController)
        navigationController.pushViewController(mapModul, animated: true)
    }
}
