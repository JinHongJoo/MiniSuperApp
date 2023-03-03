//
//  TopupRouter.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/28.
//

import ModernRIBs

protocol TopupInteractable: Interactable,
                            AddPaymentMethodListener,
                            EnterAmountListener
{
    var router: TopupRouting? { get set }
    var listener: TopupListener? { get set }
    var presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy { get }
}

protocol TopupViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class TopupRouter: Router<TopupInteractable>, TopupRouting {
    
    private let addPaymentMethodBuildable: AddPaymentMethodBuildable
    private let enterAmountBuildable: EnterAmountBuildable
    
    private var addPaymentMethod: ViewableRouting?
    private var enterAmount: ViewableRouting?
    private var navigationControllerable: NavigationControllerable?
    
    init(interactor: TopupInteractable,
         viewController: ViewControllable,
         addPaymentMethodBuildable: AddPaymentMethodBuildable,
         enterAmountBuildable: EnterAmountBuildable
    ) {
        self.viewController = viewController
        self.addPaymentMethodBuildable = addPaymentMethodBuildable
        self.enterAmountBuildable = enterAmountBuildable
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        if viewController.uiviewController.presentedViewController != nil, self.navigationControllerable != nil {
            navigationControllerable?.dismiss(completion: nil )
        }
    }
    
    func attachAddPaymentMethod() {
        if self.addPaymentMethod != nil { return }
        let router = addPaymentMethodBuildable.build(withListener: interactor)
        presentInsideNavigation(router.viewControllable)
        self.addPaymentMethod = router
        
        attachChild(router)
    }
    
    func detachAddPaymentMethod() {
        if let router = addPaymentMethod {
            dismissPresentedNavigation(completion: nil)
            detachChild(router)
            
            self.addPaymentMethod = nil
        }
    }
    
    func attachEnterAmount() {
        if self.enterAmount != nil { return }
        let router = enterAmountBuildable.build(withListener: interactor)
        presentInsideNavigation(router.viewControllable)
        self.enterAmount = router
        
        attachChild(router)
    }
    
    func detachEnterAmount() {
        if let router = enterAmount {
            dismissPresentedNavigation(completion: nil)
            detachChild(router)
            
            self.enterAmount = nil
        }
    }
    
    private func presentInsideNavigation(_ viewcontrollable: ViewControllable) {
        let navigation = NavigationControllerable(root: viewcontrollable)
        self.navigationControllerable = navigation
        navigation.navigationController.presentationController?.delegate = interactor.presentationDelegateProxy
        viewController.present(navigation, animated: true, completion: nil)
    }
    
    private func dismissPresentedNavigation(completion: (() -> Void)?) {
        if self.navigationControllerable == nil { return }
        viewController.dismiss(completion: completion)
        self.navigationControllerable = nil
    }

    // MARK: - Private

    private let viewController: ViewControllable
}
