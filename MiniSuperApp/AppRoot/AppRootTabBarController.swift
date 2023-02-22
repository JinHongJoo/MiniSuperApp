//
//  AppRootPresentableListener.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2022/11/29.
//

import ModernRIBs
import UIKit

protocol AppRootPresentableListener: AnyObject {
    
}

final class AppRootTabBarController: UITabBarController, AppRootPresentable, AppRootViewControllable {

    weak var listener: AppRootPresentableListener?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor = .black
        tabBar.backgroundColor = .white
    }
    
    func setViewControllers(_ viewControllers: [ViewControllable]) {
        super.setViewControllers(viewControllers.map{$0.uiviewController}, animated: true)
    }
}
