//
//  AddPaymentMethodInterface.swift
//  
//
//  Created by 주진홍 on 2023/03/14.
//

import Foundation
import ModernRIBs
import RIBsUtils
import FinanceEntity

public protocol AddPaymentMethodBuildable: Buildable {
    func build(withListener listener: AddPaymentMethodListener, closeButtonType: DismissButtonType) -> ViewableRouting
}

public protocol AddPaymentMethodListener: AnyObject {
    func addPaymentMethodDidTapClose()
    func addPaymentMethodDidAddCard(paymentMethod: PaymentMethod)
}
