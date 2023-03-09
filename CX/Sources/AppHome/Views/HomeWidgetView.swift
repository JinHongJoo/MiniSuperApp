//
//  HomeWidgetView.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import UIKit
import SnapKit

struct HomeWidgetViewModel {
    let image: UIImage?
    let title: String
    let tapHandler: () -> Void
    
    init(_ model: HomeWidgetModel) {
      image = UIImage(systemName: model.imageName)
      title = model.title
      tapHandler = model.tapHandler
    }
}

final class HomeWidgetView: UIView {
    
    private let imageView: UIImageView = {
      let imageView = UIImageView()
      imageView.tintColor = .black
      imageView.translatesAutoresizingMaskIntoConstraints = false
      return imageView
    }()
    
    private let titleLabel: UILabel = {
      let label = UILabel()
      label.translatesAutoresizingMaskIntoConstraints = false
      label.textAlignment = .center
      label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
      return label
    }()
    
    private var tapHandler: (() -> Void)?
    
    init(viewModel: HomeWidgetViewModel) {
        super.init(frame: .zero)
        
        setupViews()
        update(with: viewModel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func update(with viewModel: HomeWidgetViewModel) {
      imageView.image = viewModel.image
      titleLabel.text = viewModel.title
      tapHandler = viewModel.tapHandler
    }
    
    private func setupViews() {
        backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tap)
        
        [imageView, titleLabel].forEach{addSubview($0)}
        
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(15)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(5)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(14)
        }
    }
    
    @objc
    private func didTap() {
      tapHandler?()
    }
}
