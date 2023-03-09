//
//  FinanceHomeRouter.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs
import AddPaymentMethod
import SuperUI
import RIBsUtils

protocol FinanceHomeInteractable: Interactable,
                                SuperPayDashboardListener,
                                CardOnFileDashboardListener,
                                AddPaymentMethodListener,
                                TopupListener
{
    var router: FinanceHomeRouting? { get set }
    var listener: FinanceHomeListener? { get set }
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

protocol FinanceHomeViewControllable: ViewControllable {
    func addDashboard(_ view: ViewControllable)
}

final class FinanceHomeRouter: ViewableRouter<FinanceHomeInteractable, FinanceHomeViewControllable>, FinanceHomeRouting {
    
    let superPayDashboardBuildable: SuperPayDashboardBuildable
    let cardOnFileDashboardBuildable: CardOnFileDashboardBuildable
    let addPaymentMethodBuildable: AddPaymentMethodBuildable
    let topupBuildable: TopupBuildable
    
    var superPayDashboard: ViewableRouting?
    var cardOnFileDashboard: ViewableRouting?
    var addPaymentMethod: ViewableRouting?
    var topup: Routing?

    init(interactor: FinanceHomeInteractable,
         viewController: FinanceHomeViewControllable,
         superPayDashboard: SuperPayDashboardBuildable,
         cardOnFileDashboard: CardOnFileDashboardBuildable,
         addPaymentMethod: AddPaymentMethodBuildable,
         topup: TopupBuildable
    ) {
        self.superPayDashboardBuildable = superPayDashboard
        self.cardOnFileDashboardBuildable = cardOnFileDashboard
        self.addPaymentMethodBuildable = addPaymentMethod
        self.topupBuildable = topup
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
    
    func attachAddPaymentMethod() {
        if self.addPaymentMethod != nil { return }
        let router = addPaymentMethodBuildable.build(withListener: interactor, closeButtonType: .close)
        let navigation = NavigationControllerable(root: router.viewControllable)
        navigation.navigationController.presentationController?.delegate = interactor.presentationDelegateProxy
        viewController.present(navigation, animated: true, completion: nil)
        self.addPaymentMethod = router
        
        attachChild(router)
    }
    
    func detachAddPaymentMethod() {
        if let router = addPaymentMethod {
            router.viewControllable.dismiss(completion: nil)
            detachChild(router)
            
            self.addPaymentMethod = nil
        }
    }
    
    func attachTopup() {
        if self.topup != nil { return }
        let router = topupBuildable.build(withListener: interactor)
        self.topup = router
        
        attachChild(router)
    }
    
    func detachTopup() {
        if let router = self.topup {
            detachChild(router)
            
            self.topup = nil
        }
    }
}
