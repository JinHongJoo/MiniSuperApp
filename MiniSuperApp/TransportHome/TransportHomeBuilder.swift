//
//  TransportHomeBuilder.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs

protocol TransportHomeDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class TransportHomeComponent: Component<TransportHomeDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol TransportHomeBuildable: Buildable {
    func build(withListener listener: TransportHomeListener) -> TransportHomeRouting
}

final class TransportHomeBuilder: Builder<TransportHomeDependency>, TransportHomeBuildable {

    override init(dependency: TransportHomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: TransportHomeListener) -> TransportHomeRouting {
        let component = TransportHomeComponent(dependency: dependency)
        let viewController = TransportHomeViewController()
        let interactor = TransportHomeInteractor(presenter: viewController)
        interactor.listener = listener
        return TransportHomeRouter(interactor: interactor, viewController: viewController)
    }
}
