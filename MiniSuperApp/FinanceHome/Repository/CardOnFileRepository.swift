//
//  CardOnFileRepository.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/23.
//

import Foundation

protocol CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { get }
}

final class CardOnFileRepositoryImp: CardOnFileRepository {
    var cardOnFile: ReadOnlyCurrentValuePublisher<[PaymentMethod]> { paymentMethodsSubject }
    
    private let paymentMethodsSubject = CurrentValuePublisher<[PaymentMethod]>([
        PaymentMethod(id: "0", name: "카카오뱅크", digits: "2231", color: "#fd48a3ff", isPrimary: false),
        PaymentMethod(id: "1", name: "우리카드", digits: "5789", color: "#cc123dff", isPrimary: false),
        PaymentMethod(id: "2", name: "롯데카드", digits: "5468", color: "#bd4ba3ff", isPrimary: false),
        PaymentMethod(id: "3", name: "현대카드", digits: "2586", color: "#aaab3aff", isPrimary: false),
        PaymentMethod(id: "4", name: "기업은행", digits: "9942", color: "#dda8a8ff", isPrimary: false)
    ])
}
