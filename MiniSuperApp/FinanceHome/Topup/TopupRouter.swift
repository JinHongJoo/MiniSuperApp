//
//  TopupRouter.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/28.
//

import ModernRIBs

protocol TopupInteractable: Interactable,
                            AddPaymentMethodListener
{
    var router: TopupRouting? { get set }
    var listener: TopupListener? { get set }
}

protocol TopupViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy. Since
    // this RIB does not own its own view, this protocol is conformed to by one of this
    // RIB's ancestor RIBs' view.
}

final class TopupRouter: Router<TopupInteractable>, TopupRouting {
    private let addPaymentMethodBuildable: AddPaymentMethodBuildable
    
    private var addPaymentMethod: ViewableRouting?
    
    init(interactor: TopupInteractable,
         viewController: ViewControllable,
         addPaymentMethodBuildable: AddPaymentMethodBuildable
    ) {
        self.viewController = viewController
        self.addPaymentMethodBuildable = addPaymentMethodBuildable
        super.init(interactor: interactor)
        interactor.router = self
    }

    func cleanupViews() {
        // TODO: Since this router does not own its view, it needs to cleanup the views
        // it may have added to the view hierarchy, when its interactor is deactivated.
    }
    
    func attachAddPaymentMethod() {
        if self.addPaymentMethod != nil { return }
        let router = addPaymentMethodBuildable.build(withListener: interactor)
        let navigation = NavigationControllerable(root: router.viewControllable)
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

    // MARK: - Private

    private let viewController: ViewControllable
}
