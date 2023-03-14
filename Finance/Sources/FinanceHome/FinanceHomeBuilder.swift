//
//  FinanceHomeBuilder.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs
import FinanceRepository
import AddPaymentMethod
import CombineUtils
import Topup

public protocol FinanceHomeDependency: Dependency {
    var cardOnFileRepository: CardOnFileRepository { get }
    var superPayRepository: SuperPayRepository { get }
    var topupBuildable: TopupBuildable { get }
    var AddPaymentMethodBuildable: AddPaymentMethodBuildable { get }
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>,
                                    SuperPayDashboardDependency,
                                    CardOnFileDashboardDependency
{
    var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository }
    var superPayRepository: SuperPayRepository { dependency.superPayRepository }
    var balance: ReadOnlyCurrentValuePublisher<Double> { superPayRepository.balance }
    
    var topupBuildable: TopupBuildable { dependency.topupBuildable }
    var AddPaymentMethodBuildable: AddPaymentMethodBuildable { dependency.AddPaymentMethodBuildable }
}

// MARK: - Builder

public protocol FinanceHomeBuildable: Buildable {
    func build(withListener listener: FinanceHomeListener) -> ViewableRouting
}

public final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {

    public override init(dependency: FinanceHomeDependency) {
        super.init(dependency: dependency)
    }

    public func build(withListener listener: FinanceHomeListener) -> ViewableRouting {
        let viewController = FinanceHomeViewController()
        
        let component = FinanceHomeComponent(dependency: dependency)
        
        let interactor = FinanceHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        let superPayDashboard = SuperPayDashboardBuilder(dependency: component)
        let cardOnFileDashboard = CardOnFileDashboardBuilder(dependency: component)
        return FinanceHomeRouter(interactor: interactor,
                                 viewController: viewController,
                                 superPayDashboard: superPayDashboard,
                                 cardOnFileDashboard: cardOnFileDashboard,
                                 addPaymentMethod: component.AddPaymentMethodBuildable,
                                 topup: component.topupBuildable)
    }
}
