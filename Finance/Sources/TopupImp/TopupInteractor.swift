//
//  TopupInteractor.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/28.
//

import ModernRIBs
import RIBsUtils
import FinanceEntity
import FinanceRepository
import SuperUI
import CombineUtils
import Topup

public protocol TopupRouting: Routing {
    func cleanupViews()
    func attachAddPaymentMethod(closeButtonType: DismissButtonType)
    func detachAddPaymentMethod()
    func attachEnterAmount()
    func detachEnterAmount()
    func attachCardOnFile(paymentMethods: [PaymentMethod])
    func detachCardOnFile()
    func popToRoot()
}

protocol TopupInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
    var paymentMethodStream: CurrentValuePublisher<PaymentMethod> { get }
}

final class TopupInteractor: Interactor, TopupInteractable, AdaptivePresentationControllerDelegate {
    
    weak var router: TopupRouting?
    weak var listener: TopupListener?
    
    let presentationDelegateProxy: AdaptivePresentationControllerDelegateProxy
    
    private var isEnterAmountRoot: Bool = false
    
    private var paymentMathods: [PaymentMethod] {
        dependency.cardOnFileRepository.cardOnFile.value
    }
    
    private let dependency: TopupInteractorDependency
    
    init(dependency: TopupInteractorDependency) {
        self.presentationDelegateProxy = AdaptivePresentationControllerDelegateProxy()
        self.dependency = dependency
        super.init()
        self.presentationDelegateProxy.delegate = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        if let card = dependency.cardOnFileRepository.cardOnFile.value.first {
            isEnterAmountRoot = true
            dependency.paymentMethodStream.send(card)
            router?.attachEnterAmount()
        }else {
            isEnterAmountRoot = false
            router?.attachAddPaymentMethod(closeButtonType: .close)
        }
    }
    
    override func willResignActive() {
        super.willResignActive()
        
        router?.cleanupViews()
    }
    
    func addPaymentMethodDidTapClose() {
        router?.detachAddPaymentMethod()
        if isEnterAmountRoot == false {
            listener?.topupDidClose()
        }
        
    }
    
    func enterAmountDidTapClose() {
        router?.detachEnterAmount()
        listener?.topupDidClose()
    }
    
    func enterAmountDidFinishTopup() {
        listener?.topupDidfinish()
    }
    
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod) {
        dependency.paymentMethodStream.send(paymentMethod)
        if isEnterAmountRoot {
            router?.popToRoot()
        }else {
            isEnterAmountRoot = true
            router?.attachEnterAmount()
        }
    }
    
    func presentationControllerDidDismiss() {
        listener?.topupDidClose()
    }
    
    func enterAmountDidTapPaymentMethod() {
        router?.attachCardOnFile(paymentMethods: self.paymentMathods)
    }
    
    func cardOnFileDidTapClose() {
        router?.detachCardOnFile()
    }
    
    func cardOnFileDidTapAddCard() {
        router?.attachAddPaymentMethod(closeButtonType: .back)
    }
    
    func cardOnFileDidSelect(at index: Int) {
        if let selected = paymentMathods[safe: index] {
            dependency.paymentMethodStream.send(selected)
        }
        router?.detachCardOnFile()
    }
    
    
}
