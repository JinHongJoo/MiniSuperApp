//
//  EnterAmountBuilder.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/03/02.
//

import Foundation
import ModernRIBs
import CombineUtils
import FinanceEntity
import FinanceRepository
import CombineSchedulers

protocol EnterAmountDependency: Dependency {
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { get }
    var superPayRepository: SuperPayRepository { get }
    var mainQueue: AnySchedulerOf<DispatchQueue> { get}
}

final class EnterAmountComponent: Component<EnterAmountDependency>,
                                    EnterAmountInteractorDependency
{
    var mainQueue: AnySchedulerOf<DispatchQueue> { dependency.mainQueue }
    
    var superPayRepository: SuperPayRepository { dependency.superPayRepository }
    
    var selectedPaymentMethod: ReadOnlyCurrentValuePublisher<PaymentMethod> { dependency.selectedPaymentMethod }
}

// MARK: - Builder

protocol EnterAmountBuildable: Buildable {
    func build(withListener listener: EnterAmountListener) -> EnterAmountRouting
}

final class EnterAmountBuilder: Builder<EnterAmountDependency>, EnterAmountBuildable {
    
    override init(dependency: EnterAmountDependency) {
        super.init(dependency: dependency)
    }
    
    func build(withListener listener: EnterAmountListener) -> EnterAmountRouting {
        let component = EnterAmountComponent(dependency: dependency)
        let viewController = EnterAmountViewController()
        let interactor = EnterAmountInteractor(presenter: viewController, dependency: component)
        interactor.listener = listener
        return EnterAmountRouter(interactor: interactor, viewController: viewController)
    }
}
