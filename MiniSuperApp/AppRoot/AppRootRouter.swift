//
//  AppRootRouter.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2022/11/29.
//

import ModernRIBs

protocol AppRootInteractable: Interactable,
                            AppHomeListener,
                            FinanceHomeListener,
                            ProfileHomeListener
{
    var router: AppRootRouting? { get set }
    var listener: AppRootListener? { get set }
}

protocol AppRootViewControllable: ViewControllable {
    func setViewControllers(_ viewControllers: [ViewControllable])
}

final class AppRootRouter: LaunchRouter<AppRootInteractable, AppRootViewControllable>, AppRootRouting {
    private let appHomeBuilder: AppHomeBuildable
    private let financeHomeBuilder: FinanceHomeBuildable
    private let profileHomeBuilder: ProfileHomeBuildable

    init(interactor: AppRootInteractable,
         viewController: AppRootViewControllable,
         appHome: AppHomeBuildable,
         financeHome: FinanceHomeBuildable,
         profileHome: ProfileHomeBuildable)
    {
        self.appHomeBuilder = appHome
        self.financeHomeBuilder = financeHome
        self.profileHomeBuilder = profileHome
        
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        
        let appHome = appHomeBuilder.build(withListener: interactor)
        let financeHome = financeHomeBuilder.build(withListener: interactor)
        let profileHome = profileHomeBuilder.build(withListener: interactor)
        
        attachChild(appHome)
        attachChild(financeHome)
        attachChild(profileHome)
        viewController.setViewControllers(
            [
                NavigationControllerable(root: appHome.viewControllable),
                NavigationControllerable(root: financeHome.viewControllable),
                profileHome.viewControllable
            ]
        )
        
    }
}
