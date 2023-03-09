//
//  AddPaymentMethodButton.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/23.
//

import UIKit
import SnapKit

final class AddPaymentMethodButton: UIControl {
    
    private let pluseIcon: UIImageView = {
        let imageView = UIImageView(
            image: UIImage(
                systemName: "plus",
                withConfiguration: UIImage.SymbolConfiguration(pointSize: 24, weight: .semibold)
            )
        )
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(pluseIcon)
        
        pluseIcon.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
