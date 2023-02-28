//
//  TopupBuilder.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/28.
//

import ModernRIBs

protocol TopupDependency: Dependency {
    var topupBaseViewController: ViewControllable { get }
    var cardOnFileRepository: CardOnFileRepository { get }
}

final class TopupComponent: Component<TopupDependency>,
                            TopupInteractorDependency,
                            AddPaymentMethodDependency
{
    var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository}
    fileprivate var topupBaseViewController: ViewControllable { dependency.topupBaseViewController }
}

// MARK: - Builder

protocol TopupBuildable: Buildable {
    func build(withListener listener: TopupListener) -> TopupRouting
}

final class TopupBuilder: Builder<TopupDependency>, TopupBuildable {

    override init(dependency: TopupDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TopupListener) -> TopupRouting {
        let component = TopupComponent(dependency: dependency)
        let interactor = TopupInteractor(dependency: component)
        interactor.listener = listener
        
        let addPaymentMethod = AddPaymentMethodBuilder(dependency: component)
        return TopupRouter(interactor: interactor,
                           viewController: component.topupBaseViewController,
                           addPaymentMethodBuildable: addPaymentMethod)
    }
}