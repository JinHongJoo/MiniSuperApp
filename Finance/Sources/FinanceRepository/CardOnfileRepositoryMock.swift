//
//  File.swift
//  
//
//  Created by 주진홍 on 2023/03/21.
//

import Foundation
import Combine
import CombineUtils
import FinanceEntity


public final class CardOnfileRepositoryMock: CardOnFileRepository {
    public var cardOnFileSubject: CurrentValuePublisher<[PaymentMethod]> = .init([])
    public var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { cardOnFileSubject }
    
    public var addCardCallCount = 0
    public var addCardInfo: AddPaymentMethodInfo?
    public var paymentMethod: PaymentMethod?
    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error> {
        addCardCallCount += 1
        addCardInfo = info
        
        if let paymentMethod = paymentMethod {
            return Just(paymentMethod).setFailureType(to: Error.self).eraseToAnyPublisher()
        }else {
            return Fail(error: NSError(domain: "CardOnFileRepositoryMock", code: 0, userInfo: nil)).eraseToAnyPublisher()
        }
    }
    
    public var fetchCallCount = 0
    public func fetch() {
        fetchCallCount += 1
    }
    
    public init() {
        
    }
    
    
}
