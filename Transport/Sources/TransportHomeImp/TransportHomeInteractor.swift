//
//  TransportHomeInteractor.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs
import Combine
import CombineUtils
import Foundation
import TransportHome

protocol TransportHomeRouting: ViewableRouting {
    func attachTopup()
    func detachTopup()
}

protocol TransportHomePresentable: Presentable {
    var listener: TransportHomePresentableListener? { get set }
    func setSuperPayBalance(_ balanceText: String)
}

protocol TransportHomeInteractorDependency {
    var superPayBalance: ReadOnlyCurrentValuePublisher<Double> { get }
}

final class TransportHomeInteractor: PresentableInteractor<TransportHomePresentable>, TransportHomeInteractable, TransportHomePresentableListener {
    
    weak var router: TransportHomeRouting?
    weak var listener: TransportHomeListener?
    
    private let dependency: TransportHomeInteractorDependency
    
    private var cancellables: Set<AnyCancellable>
    
    private let ridePrice: Double = 18000
    
    init(
        presenter: TransportHomePresentable,
        dependency: TransportHomeInteractorDependency
    ) {
        self.dependency = dependency
        self.cancellables = .init()
        super.init(presenter: presenter)
        presenter.listener = self
    }
    
    override func didBecomeActive() {
        super.didBecomeActive()
        
        dependency.superPayBalance
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                if let balanceText = Formatter.balanceFormatter.string(from: NSNumber(value: $0)) {
                    self?.presenter.setSuperPayBalance(balanceText)
                }
            }
            .store(in: &cancellables)
    }
    
    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func didTapBack() {
        listener?.transportHomeDidTapClose()
    }
    
    func didTapRideConfirmButton() {
        if dependency.superPayBalance.value < ridePrice {
            router?.attachTopup()
        }else {
            print("Success")
        }
    }
    
    func topupDidClose() {
        router?.detachTopup()
    }
    
    func topupDidfinish() {
        router?.detachTopup()
    }
}
