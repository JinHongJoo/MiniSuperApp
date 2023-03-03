//
//  UIViewController+Utils.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/03/02.
//

import UIKit

extension UIViewController {
    func setupNavigationItem(target: Any?, action: Selector?) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            image: UIImage(
                systemName: "xmark",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .semibold)
            ),
            style: .plain,
            target: target,
            action: action
        )
    }
}
