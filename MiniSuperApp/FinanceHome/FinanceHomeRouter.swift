//
//  FinanceHomeRouter.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs

protocol FinanceHomeInteractable: Interactable, SuperPayDashboardListener, CardOnFileDashboardListener {
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    let superPayDashboardBuildable: SuperPayDashboardBuildable
    let cardOnFileDashboardBuildable: CardOnFileDashboardBuildable
    var superPayDashboard: ViewableRouting?
    var cardOnFileDashboard: ViewableRouting?

    init(interactor: FinanceHomeInteractable,
         viewController: FinanceHomeViewControllable,
         superPayDashboard: SuperPayDashboardBuildable,
         cardOnFileDashboard: CardOnFileDashboardBuildable
    ) {
        self.superPayDashboardBuildable = superPayDashboard
        self.cardOnFileDashboardBuildable = cardOnFileDashboard
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachSuperPayDashboard() {
        if self.superPayDashboard != nil { return }
        let router = superPayDashboardBuildable.build(withListener: interactor)
        let dashboard = router.viewControllable
        viewController.addDashboard(dashboard)
        self.superPayDashboard = router
        
        attachChild(router)
    }
    
    func attachCardOnFileDashboard() {
        if self.cardOnFileDashboard != nil { return }
        let router = cardOnFileDashboardBuildable.build(withListener: interactor)
        let dashboard = router.viewControllable
        viewController.addDashboard(dashboard)
        self.cardOnFileDashboard = router
        
        attachChild(router)
    }
}
