//
//  PSWMapPresenter.swift
//  PSW_Test
//
//  Created by Daniil on 25.03.2023.
//

import Foundation

final class PSWMapPresenter: PSWMapPresenterProtocol {
    var isMenuShown = false
    
    private weak var view: PSWMapViewProtocol?
    private var router: Routable
    
    init(view: PSWMapViewProtocol?, router: Routable) {
        self.view = view
        self.router = router
    }
}
