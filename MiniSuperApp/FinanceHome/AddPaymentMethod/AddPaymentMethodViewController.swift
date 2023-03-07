//
//  AddPaymentMethodViewController.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/23.
//

import ModernRIBs
import UIKit
import SnapKit

protocol AddPaymentMethodPresentableListener: AnyObject {
    func didTapClose()
    func didTapAddCard(number: String, cvc: String, expiry: String)
}

final class AddPaymentMethodViewController: UIViewController, AddPaymentMethodPresentable, AddPaymentMethodViewControllable {
    
    weak var listener: AddPaymentMethodPresentableListener?
    
    private let cardNumberTextField: UITextField = {
        let textField = makeTextfield()
        textField.placeholder = "카드 번호"
        return textField
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        return stackView
    }()
    
    private let securityTextField: UITextField = {
        let textField = makeTextfield()
        textField.placeholder = "CVC"
        return textField
    }()
    
    private let expirationTextField: UITextField = {
        let textField = makeTextfield()
        textField.placeholder = "유효기간"
        return textField
    }()
    
    private lazy var addCardButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.roundCorners()
        button.backgroundColor = .primaryRed
        button.setTitle("추가하기", for: .normal)
        button.addTarget(self, action: #selector(didTapAddCard), for: .touchUpInside)
        return button
    }()
    
    private static func makeTextfield() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }
    
    init(closeButtonType: DismissButtonType) {
        super.init(nibName: nil, bundle: nil)
        
        setupViews()
        setupNavigationItem(with: closeButtonType, target: self, action: #selector(didTapClose))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        title = "카드 추가"
        view.backgroundColor = .backgroundColor
        [cardNumberTextField, stackView, addCardButton].forEach { view.addSubview($0) }
        
        cardNumberTextField.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(60)
        }
        
        stackView.addArrangedSubview(securityTextField)
        stackView.addArrangedSubview(expirationTextField)
        securityTextField.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        expirationTextField.snp.makeConstraints {
            $0.height.equalTo(60)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(cardNumberTextField.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(40)
        }
        
        addCardButton.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(40)
            $0.height.equalTo(60)
        }
    }
    
    @objc
    private func didTapAddCard() {
        if let number = cardNumberTextField.text,
           let cvc = securityTextField.text,
           let expiry = expirationTextField.text {
            listener?.didTapAddCard(number: number, cvc: cvc, expiry: expiry)
        }
    }
    
    @objc
    private func didTapClose() {
        listener?.didTapClose()
    }
}
