//
//  AppComponent.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2022/11/29.
//

import ModernRIBs

class AppComponent: Component<EmptyComponent>, AppRootDependency {
    
    init() {
        super.init(dependency: EmptyComponent())
    }
}
