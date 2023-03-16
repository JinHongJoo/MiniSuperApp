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
import NetworkImp

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
         rootViewController: ViewControllable
    ) {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [SuperAppURLProtocol.self]
        setupURLProtocol()
        let network = NetworkImp(session: URLSession(configuration: config))
    
        self.cardOnFileRepository = CardOnFileRepositoryImp(network: network, baseURL: BaseURL().financeBaseURL)
        self.cardOnFileRepository.fetch()
        self.superPayRepository = SuperPayRepositoryImp(network: network, baseURL: BaseURL().financeBaseURL)
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
}
