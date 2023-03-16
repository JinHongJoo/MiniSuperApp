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
    
    let addCardResponse: [String: Any] = [
        "card": [
            "id": "999",
            "name": "새 카드",
            "digits": "**** 0101",
            "color": "",
            "isPrimary": false
        ]
    ]
    let addCardResponseData = try! JSONSerialization.data(withJSONObject: addCardResponse, options: [])
    
    let cardOnFileResponse: [String:Any] = [
        "cards": [
            [
                "id": "0",
                "name": "카카오뱅크",
                "digits": "2231",
                "color": "#fd48a3ff",
                "isPrimary": false
            ],
            [
                "id": "1",
                "name": "우리카드",
                "digits": "5789",
                "color": "#cc123dff",
                "isPrimary": false
            ],
            [
                "id": "2",
                "name": "롯데카드",
                "digits": "5468",
                "color": "#bd4ba3ff",
                "isPrimary": false
            ],
            [
                "id": "3",
                "name": "현대카드",
                "digits": "2586",
                "color": "#aaab3aff",
                "isPrimary": false
            ],
            [
                "id": "4",
                "name": "기업은행",
                "digits": "9942",
                "color": "#dda8a8ff",
                "isPrimary": false
            ]
            
        ]
    ]
    let cardOnFileResponseData = try! JSONSerialization.data(withJSONObject: cardOnFileResponse, options: [])
    
    SuperAppURLProtocol.successMock = [
        "/api/v1/topup": (200, topupResponseData),
        "/api/v1/addCard": (200, addCardResponseData),
        "/api/v1/cards": (200, cardOnFileResponseData),
    ]
}
