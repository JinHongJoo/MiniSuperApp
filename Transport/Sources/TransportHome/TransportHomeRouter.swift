//
//  TransportHomeRouter.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs
import Topup

protocol TransportHomeInteractable: Interactable,
                                    TopupListener
{
    var router: TransportHomeRouting? { get set }
    var listener: TransportHomeListener? { get set }
}

protocol TransportHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TransportHomeRouter: ViewableRouter<TransportHomeInteractable, TransportHomeViewControllable>, TransportHomeRouting {
    
    private let topupBuildable: TopupBuildable
    
    private var topup: Routing?
    
    init(
        interactor: TransportHomeInteractable,
        viewController: TransportHomeViewControllable,
        topupBuildable: TopupBuildable
    ) {
        self.topupBuildable = topupBuildable
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTopup() {
        if self.topup == nil {
            let router = topupBuildable.build(withListener: interactor)
            self.topup = router
            
            attachChild(router)
        }
    }
    
    func detachTopup() {
        if let topup = self.topup {
            detachChild(topup)
            self.topup = nil
        }
    }
}
