//
//  Formatter.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/03/09.
//

import Foundation

struct Formatter {
    static let balanceFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
}
