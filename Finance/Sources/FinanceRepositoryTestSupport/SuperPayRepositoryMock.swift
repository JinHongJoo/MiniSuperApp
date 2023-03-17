//
//  SuperPayRepositoryMock.swift
//  
//
//  Created by 주진홍 on 2023/03/16.
//

import Foundation
import Combine
import CombineUtils
import FinanceRepository

public final class SuperPayRepositoryMock: SuperPayRepository {
    public var balanceSubject = CurrentValuePublisher<Double>(0)
    public var balance: ReadOnlyCurrentValuePublisher<Double> { balanceSubject }
    
    public var topupCallCount = 0
    public var topupAmount: Double?
    public var paymentMethodID: String?
    public var shouldTopupSuccessed: Bool = true
    public func topup(amount: Double, paymentMethodID: String) -> AnyPublisher<Void, Error> {
        topupCallCount += 1
        topupAmount = amount
        self.paymentMethodID = paymentMethodID
        
        if shouldTopupSuccessed {
            return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
        }else {
            return Fail(error: NSError(domain: "SuperPayRepositoryMock", code: 0, userInfo: nil)).eraseToAnyPublisher()
        }
    }
    
    public init() {
        
    }
}
