//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/28.
//

import ModernRIBs

protocol TopupRouting: Routing {
    func cleanupViews()
    func attachAddPaymentMethod()
    func detachAddPaymentMethod()
}

protocol TopupListener: AnyObject {
    func topupDidClose()
}

protocol TopupInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
}

final class TopupInteractor: Interactor, TopupInteractable {

    weak var router: TopupRouting?
    weak var listener: TopupListener?

    private let dependency: TopupInteractorDependency
    
    init(dependency: TopupInteractorDependency) {
        self.dependency = dependency
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        if dependency.cardOnFileRepository.cardOnFile.value.isEmpty {
            router?.attachAddPaymentMethod()
        }else {
            
        }
        
    }

    override func willResignActive() {
        super.willResignActive()

        router?.cleanupViews()
        // TODO: Pause any business logic.
    }
    
    func addPaymentMethodDidTapClose() {
        router?.detachAddPaymentMethod()
        listener?.topupDidClose()
    }
    
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {
        
    }
}
