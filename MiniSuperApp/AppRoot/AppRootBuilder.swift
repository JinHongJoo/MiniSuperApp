//
//  AppRootBuilder.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2022/11/29.
//

import ModernRIBs

protocol AppRootDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class AppRootComponent: Component<AppRootDependency>,
                            AppHomeDependency,
                            FinanceHomeDependency,
                            ProfileHomeDependency
{

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol AppRootBuildable: Buildable {
    func build() -> LaunchRouting
}

final class AppRootBuilder: Builder<AppRootDependency>, AppRootBuildable {

    override init(dependency: AppRootDependency) {
        super.init(dependency: dependency)
    }

    func build() -> LaunchRouting {
        let component = AppRootComponent(dependency: dependency)
        let viewController = AppRootTabBarController()
        let interactor = AppRootInteractor(presenter: viewController)
        
        let appHome = AppHomeBuilder(dependency: component)
        let financeHome = FinanceHomeBuilder(dependency: component)
        let profileHome = ProfileHomeBuilder(dependency: component)
        let router = AppRootRouter(
            interactor: interactor,
            viewController: viewController,
            appHome: appHome,
            financeHome: financeHome,
            profileHome: profileHome
        )
        
        return router
    }
}
