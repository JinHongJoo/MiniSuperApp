//
//  FinanceHomeBuilder.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs

protocol FinanceHomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class FinanceHomeComponent: Component<FinanceHomeDependency>,
                                    SuperPayDashboardDependency,
                                    CardOnFileDashboardDependency,
                                    AddPaymentMethodDependency,
                                    TopupDependency
{
    var topupBaseViewController: ViewControllable
    
    let cardOnFileRepository: CardOnFileRepository
    
    var balance: ReadOnlyCurrentValuePublisher<Double> { balancePublisher }
    
    let balancePublisher: CurrentValuePublisher<Double>
    
    init(dependency: FinanceHomeDependency,
         balance: CurrentValuePublisher<Double>,
         cardOnFileRepository: CardOnFileRepository,
         topupBaseViewController: ViewControllable
    ) {
        self.balancePublisher = balance
        self.cardOnFileRepository = cardOnFileRepository
        self.topupBaseViewController = topupBaseViewController
        super.init(dependency: dependency)
    }
}

// MARK: - Builder

protocol FinanceHomeBuildable: Buildable {
    func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting
}

final class FinanceHomeBuilder: Builder<FinanceHomeDependency>, FinanceHomeBuildable {

    override init(dependency: FinanceHomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: FinanceHomeListener) -> FinanceHomeRouting {
        let balancePublisher = CurrentValuePublisher<Double>(10000)
        let viewController = FinanceHomeViewController()
        
        let component = FinanceHomeComponent(
            dependency: dependency,           
            balance: balancePublisher,
            cardOnFileRepository: CardOnFileRepositoryImp(),
            topupBaseViewController: viewController
        )
        
        let interactor = FinanceHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        let superPayDashboard = SuperPayDashboardBuilder(dependency: component)
        let cardOnFileDashboard = CardOnFileDashboardBuilder(dependency: component)
        let addPaymentMethod = AddPaymentMethodBuilder(dependency: component)
        let topup = TopupBuilder(dependency: component)
        return FinanceHomeRouter(interactor: interactor,
                                 viewController: viewController,
                                 superPayDashboard: superPayDashboard,
                                 cardOnFileDashboard: cardOnFileDashboard,
                                 addPaymentMethod: addPaymentMethod,
                                 topup: topup)
    }
}
