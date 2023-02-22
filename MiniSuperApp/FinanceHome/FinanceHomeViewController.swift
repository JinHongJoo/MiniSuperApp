//
//  FinanceHomeViewController.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs
import UIKit

protocol FinanceHomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class FinanceHomeViewController: UIViewController, FinanceHomePresentable, FinanceHomeViewControllable {

    weak var listener: FinanceHomePresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
      title = "슈퍼페이"
      tabBarItem = UITabBarItem(title: "슈퍼페이", image: UIImage(systemName: "creditcard"), selectedImage: UIImage(systemName: "creditcard.fill"))
      view.backgroundColor = .systemBlue
    }
}
