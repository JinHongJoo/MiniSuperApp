//
//  PaymentMethodViewModel.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/23.
//

import UIKit
import FinanceEntity

public struct PaymentMethodViewModel {
    public let name: String
    public let digits: String
    public let color: UIColor
    
    public init(_ paymentMethod: PaymentMethod) {
        name = paymentMethod.name
        digits = "**** \(paymentMethod.digits)"
        color = UIColor(hex: paymentMethod.color) ?? .systemGray2
    }
}
