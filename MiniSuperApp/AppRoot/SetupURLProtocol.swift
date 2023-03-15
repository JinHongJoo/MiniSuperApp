//
//  SetupURLProtocol.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/03/15.
//

import Foundation

func setupURLProtocol() {
    let topupResponse: [String: Any] = [
        "status": "success"
    ]
    
    let topupResponseData = try! JSONSerialization.data(withJSONObject: topupResponse, options: [])
    
    SuperAppURLProtocol.successMock = ["/api/v1/topup": (200, topupResponseData)]
}
