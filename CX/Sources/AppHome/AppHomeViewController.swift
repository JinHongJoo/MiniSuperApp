//
//  AppHomeViewController.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs
import UIKit
import SuperUI

protocol AppHomePresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class AppHomeViewController: UIViewController, AppHomePresentable, AppHomeViewControllable {

    weak var listener: AppHomePresentableListener?
    
    private let widgetStackView: UIStackView = {
      let stackView = UIStackView()
      stackView.translatesAutoresizingMaskIntoConstraints = false
      stackView.axis = .horizontal
      stackView.distribution = .fillEqually
      stackView.alignment = .top
      stackView.spacing = 20
      return stackView
    }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        title = "홈"
        tabBarItem = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        view.backgroundColor = .backgroundColor
        view.addSubview(widgetStackView)
        
        widgetStackView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    func updateWidget(_ widgetViewModels: [HomeWidgetViewModel]) {
        let views = widgetViewModels.map { HomeWidgetView(viewModel: $0) }
        
        views.forEach {
            $0.addShadowWithRoundedCorners()
            widgetStackView.addArrangedSubview($0)
        }
    }
    
}
