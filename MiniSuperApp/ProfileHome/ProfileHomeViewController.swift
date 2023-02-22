//
//  ProfileHomeViewController.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs
import UIKit

protocol ProfileHomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class ProfileHomeViewController: UIViewController, ProfileHomePresentable, ProfileHomeViewControllable {

    weak var listener: ProfileHomePresentableListener?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
      tabBarItem = UITabBarItem(title: "프로필", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
      view.backgroundColor = .systemTeal
    }
}
