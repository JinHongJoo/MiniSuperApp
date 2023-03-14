//
//  AppRootComponent.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/03/13.
//

import Foundation
import ModernRIBs
import AppHome
import FinanceHome
import TransportHome
import TransportHomeImp
import ProfileHome
import FinanceRepository
import Topup
import TopupImp
import AddPaymentMethod
import AddPaymentMethodImp

final class AppRootComponent: Component<AppRootDependency>,
                            AppHomeDependency,
                            FinanceHomeDependency,
                            TransportHomeDependency,
                            ProfileHomeDependency,
                            TopupDependency,
                            AddPaymentMethodDependency
{
    
    var cardOnFileRepository: CardOnFileRepository
    var superPayRepository: SuperPayRepository
    
    lazy var transportHomeBuildable: TransportHomeBuildable = {
        return TransportHomeBuilder(dependency: self)
    }()
    
    lazy var topupBuildable: TopupBuildable = {
        return TopupBuilder(dependency: self)
    }()
    lazy var AddPaymentMethodBuildable: AddPaymentMethodBuildable = {
        return AddPaymentMethodBuilder(dependency: self)
    }()
    
    var topupBaseViewController: ViewControllable { rootViewController.topViewControllable }

    private let rootViewController: ViewControllable
    
    init(dependency: AppRootDependency,
         cardOnFileRepository: CardOnFileRepository,
         superPayRepository: SuperPayRepository,
         rootViewController: ViewControllable
    ) {
        self.cardOnFileRepository = cardOnFileRepository
        self.superPayRepository = superPayRepository
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}
