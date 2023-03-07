//
//  AppHomeBuilder.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs

protocol AppHomeDependency: Dependency {
    var cardOnFileRepository: CardOnFileRepository { get }
    var superPayRepository: SuperPayRepository { get }
}

final class AppHomeComponent: Component<AppHomeDependency>, TransportHomeDependency {
    var cardOnFileRepository: CardOnFileRepository { dependency.cardOnFileRepository }
    var superPayRepository: SuperPayRepository { dependency.superPayRepository }
}

// MARK: - Builder

protocol AppHomeBuildable: Buildable {
    func build(withListener listener: AppHomeListener) -> AppHomeRouting
}

final class AppHomeBuilder: Builder<AppHomeDependency>, AppHomeBuildable {

    override init(dependency: AppHomeDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: AppHomeListener) -> AppHomeRouting {
        let component = AppHomeComponent(dependency: dependency)
        let viewController = AppHomeViewController()
        let interactor = AppHomeInteractor(presenter: viewController)
        interactor.listener = listener
        
        let transportHome = TransportHomeBuilder(dependency: component)
        return AppHomeRouter(interactor: interactor,
                             viewController: viewController,
                             transportHome: transportHome)
    }
}
