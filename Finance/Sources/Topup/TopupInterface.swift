//
//  TopupInterface.swift
//  
//
//  Created by 주진홍 on 2023/03/14.
//

import Foundation
import ModernRIBs

public protocol TopupBuildable: Buildable {
    func build(withListener listener: TopupListener) -> Routing
}

public protocol TopupListener: AnyObject {
    func topupDidClose()
    func topupDidfinish()
}
