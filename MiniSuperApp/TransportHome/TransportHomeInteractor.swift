//
//  TransportHomeInteractor.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs

protocol TransportHomeRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol TransportHomePresentable: Presentable {
    var listener: TransportHomePresentableListener? { get set }
    func setSuperPayBalance(_ balanceText: String)
}

protocol TransportHomeListener: AnyObject {
    func transportHomeDidTapClose()
}

final class TransportHomeInteractor: PresentableInteractor<TransportHomePresentable>, TransportHomeInteractable, TransportHomePresentableListener {

    weak var router: TransportHomeRouting?
    weak var listener: TransportHomeListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: TransportHomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        presenter.setSuperPayBalance("babo")
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapBack() {
        listener?.transportHomeDidTapClose()
    }
}
