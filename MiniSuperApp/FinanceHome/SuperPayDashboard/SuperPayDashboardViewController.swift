//
//  SuperPayDashboardViewController.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/22.
//

import ModernRIBs
import UIKit
import SnapKit

protocol SuperPayDashboardPresentableListener: AnyObject {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class SuperPayDashboardViewController: UIViewController, SuperPayDashboardPresentable, SuperPayDashboardViewControllable {

    weak var listener: SuperPayDashboardPresentableListener?
    
    private let headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.text = "슈퍼페이 잔고"
        return label
    }()
    
    private lazy var topupButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("충전하기", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(topupButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    private let cardView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.cornerCurve = .continuous
        view.backgroundColor = .systemIndigo
        return view
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.text = "원"
        label.textColor = .white
        return label
    }()
    
    private let balanceAmountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let balanceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 4
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
        [headerStackView, cardView, balanceStackView].forEach { view.addSubview($0) }
        
        headerStackView.addArrangedSubview(titleLabel)
        headerStackView.addArrangedSubview(topupButton)
        headerStackView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        cardView.snp.makeConstraints {
            $0.top.equalTo(headerStackView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(180)
        }
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        balanceStackView.addArrangedSubview(currencyLabel)
        balanceStackView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(cardView)
        }
        
    }
    
    func updateBalance(_ balance: String) {
        balanceAmountLabel.text = balance
    }
    
    @objc
    private func topupButtonDidTap() {
        
    }
}
