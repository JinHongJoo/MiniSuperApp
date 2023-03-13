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

final class AppRootComponent: Component<AppRootDependency>,
                            AppHomeDependency,
                            FinanceHomeDependency,
                            TransportHomeDependency,
                            ProfileHomeDependency
{
    var cardOnFileRepository: CardOnFileRepository
    var superPayRepository: SuperPayRepository
    
    lazy var transportHomeBuildable: TransportHomeBuildable = {
        return TransportHomeBuilder(dependency: self)
    }()
    
    init(dependency: AppRootDependency,
         cardOnFileRepository: CardOnFileRepository,
         superPayRepository: SuperPayRepository
    ) {
        self.cardOnFileRepository = cardOnFileRepository
        self.superPayRepository = superPayRepository
        super.init(dependency: dependency)
    }
}
