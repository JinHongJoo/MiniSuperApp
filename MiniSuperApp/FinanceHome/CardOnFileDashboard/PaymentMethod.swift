//
//  PaymentMethod.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/23.
//

import Foundation

struct PaymentMethod: Decodable {
    let id: String
    let name: String
    let digits: String
    let color: String
    let isPrimary: Bool
}
