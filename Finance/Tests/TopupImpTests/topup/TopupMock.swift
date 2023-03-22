//
//  File.swift
//  
//
//  Created by 주진홍 on 2023/03/21.
//

import Foundation
import FinanceRepository
import FinanceEntity
import CombineUtils
@testable import TopupImp

final class TopupDependencyMock: TopupInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository = CardOnfileRepositoryMock()
    var paymentMethodStream: CurrentValuePublisher<PaymentMethod> = .init(PaymentMethod(id: "", name: "", digits: "", color: "", isPrimary: false))
}
