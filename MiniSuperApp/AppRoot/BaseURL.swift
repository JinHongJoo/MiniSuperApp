//
//  BaseURL.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/03/15.
//

import Foundation

struct BaseURL {
    var financeBaseURL: URL {
        return URL(string: "https://finance.superapp.com/api/v1")!
    }
}
