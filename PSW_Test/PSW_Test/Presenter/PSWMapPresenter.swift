//
//  PSWMapPresenter.swift
//  PSW_Test
//
//  Created by Daniil on 25.03.2023.
//

import Foundation

/// Презентер карты
final class PSWMapPresenter: PSWMapPresenterProtocol {
    // MARK: - Public properties
    
    var isMenuShown = false
    
    // MARK: - Private properties
    
    private weak var view: PSWMapViewProtocol?
    private var router: Routable
    
    // MARK: - init
    
    init(view: PSWMapViewProtocol?, router: Routable) {
        self.view = view
        self.router = router
    }
}
