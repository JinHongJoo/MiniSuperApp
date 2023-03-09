//
//  CardOnFileDashboardInteractor.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/23.
//

import ModernRIBs
import Combine
import FinanceRepository
import Topup

protocol CardOnFileDashboardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol CardOnFileDashboardPresentable: Presentable {
    var listener: CardOnFileDashboardPresentableListener? { get set }
    
    func update(with viewModels: [PaymentMethodViewModel])
}

protocol CardOnFileDashboardListener: AnyObject {
    func cardOnFileDashboardDidTapAddPaymentMethod()
}

protocol CardOnFileDashboardInteractorDependency {
    var cardOnFileRepository: CardOnFileRepository { get }
}

final class CardOnFileDashboardInteractor: PresentableInteractor<CardOnFileDashboardPresentable>, CardOnFileDashboardInteractable, CardOnFileDashboardPresentableListener {

    weak var router: CardOnFileDashboardRouting?
    weak var listener: CardOnFileDashboardListener?
    
    private let dependency: CardOnFileDashboardInteractorDependency
    
    private var cancellables: Set<AnyCancellable>
    
    init(presenter: CardOnFileDashboardPresentable,
         dependency: CardOnFileDashboardInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        dependency.cardOnFileRepository.cardOnFile
            .sink { [weak self] method in
                let viewModels = method.prefix(5).map { PaymentMethodViewModel($0) }
                self?.presenter.update(with: viewModels)
            }.store(in: &cancellables)
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapAddPaymentMethod() {
        listener?.cardOnFileDashboardDidTapAddPaymentMethod()
    }
}
