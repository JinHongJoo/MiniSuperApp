//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/23.
//

import Foundation
import Combine
import CombineUtils
import FinanceEntity
import Network

public protocol CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
    func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error>
    func fetch()
}

public final class CardOnFileRepositoryImp: CardOnFileRepository {
    
    public var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }
    
    private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
//        PaymentMethod(id: "0", name: "카카오뱅크", digits: "2231", color: "#fd48a3ff", isPrimary: false),
//        PaymentMethod(id: "1", name: "우리카드", digits: "5789", color: "#cc123dff", isPrimary: false),
//        PaymentMethod(id: "2", name: "롯데카드", digits: "5468", color: "#bd4ba3ff", isPrimary: false),
//        PaymentMethod(id: "3", name: "현대카드", digits: "2586", color: "#aaab3aff", isPrimary: false),
//        PaymentMethod(id: "4", name: "기업은행", digits: "9942", color: "#dda8a8ff", isPrimary: false)
    ])
    
    public func addCard(info: AddPaymentMethodInfo) -> AnyPublisher<PaymentMethod, Error> {
        let request = AddCardRequest(baseURL: baseURL, info: info)
        return network.send(request)
            .map(\.output.card)
            .handleEvents(
                receiveSubscription: nil,
                receiveOutput: { [weak self] method in
                    guard let this = self else {
                        return
                    }
                    this.paymentMethodsSubject.send(this.paymentMethodsSubject.value + [method])
                },
                receiveCompletion: nil,
                receiveCancel: nil,
                receiveRequest: nil
            )
            .eraseToAnyPublisher()
        
//        let paymentMethod = PaymentMethod(id: "00", name: "New 카드", digits: "\(info.number.suffix(4))", color: "", isPrimary: false)
//
//        var new = paymentMethodsSubject.value
//        new.append(paymentMethod)
//        paymentMethodsSubject.send(new)
//
//        return Just(paymentMethod).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    public func fetch() {
        let request = CardOnFileRequest(baseURL: baseURL)
        network.send(request)
            .map(\.output.cards)
            .sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] cards in
                    self?.paymentMethodsSubject.send(cards)
                }
            ).store(in: &cancellables)
    }
    
    private let network: Network
    private let baseURL: URL
    private var cancellables: Set<AnyCancellable>
    
    public init(network: Network, baseURL: URL){
        self.network = network
        self.baseURL = baseURL
        self.cancellables = .init()
    }
}
