//
//  AppHomeRouter.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs

protocol AppHomeInteractable: Interactable, TransportHomeListener {
    var router: AppHomeRouting? { get set }
    var listener: AppHomeListener? { get set }
}

protocol AppHomeViewControllable: ViewControllable {
}

final class AppHomeRouter: ViewableRouter<AppHomeInteractable, AppHomeViewControllable>, AppHomeRouting {
    
    let transportHomeBuilder: TransportHomeBuildable
    private var currentChild: ViewableRouting?
    private let transitioningDelegate: PushModalPresentationController
    
    init(interactor: AppHomeInteractable,
              viewController: AppHomeViewControllable,
              transportHome: TransportHomeBuildable)
    {
        self.transportHomeBuilder = transportHome
        self.transitioningDelegate = PushModalPresentationController()
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    func attachTransportHome() {
        if currentChild != nil {
            return
        }
        let transportHome = transportHomeBuilder.build(withListener: interactor)
        attachChild(transportHome)
        presentWithPushTransition(transportHome.viewControllable, animated: true)
        currentChild = transportHome
    }
    
    func detachTransportHome() {
        if let currentChild = currentChild {
            viewController.dismiss(completion: nil)
            detachChild(currentChild)
            self.currentChild = nil
        }
        
    }
    
    private func presentWithPushTransition(_ viewControllable: ModernRIBs.ViewControllable, animated: Bool) {
        viewControllable.uiviewController.modalPresentationStyle = .custom
        viewControllable.uiviewController.transitioningDelegate = transitioningDelegate
        viewController.present(viewControllable, animated: true, completion: nil)
    }
}
