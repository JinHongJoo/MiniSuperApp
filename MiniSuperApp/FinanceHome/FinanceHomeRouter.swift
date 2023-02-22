//
//  FinanceHomeRouter.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener{
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    let superPayDashboardBuilder: SuperPayDashboardBuildable
    var dashboard: ViewableRouting?

    init(interactor: FinanceHomeInteractable,
                  viewController: FinanceHomeViewControllable,
                  superPayDashboard: SuperPayDashboardBuildable)
    {
        self.superPayDashboardBuilder = superPayDashboard
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSuperPayDashboard() {
        if self.dashboard != nil { return }
        let router = superPayDashboardBuilder.build(withListener: interactor)
        let dashboard = router.viewControllable
        viewController.addDashboard(dashboard)
        self.dashboard = router
        
        attachChild(router)
    }
}
