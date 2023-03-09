//
//  AppHomeInteractor.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs

protocol AppHomeRouting: ViewableRouting {
    func attachTransportHome()
    func detachTransportHome()
}

protocol AppHomePresentable: Presentable {
    var listener: AppHomePresentableListener? { get set }
    func updateWidget(_ widgetViewModels: [HomeWidgetViewModel])
}

public protocol AppHomeListener: AnyObject {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class AppHomeInteractor: PresentableInteractor<AppHomePresentable>, AppHomeInteractable, AppHomePresentableListener {

    weak var router: AppHomeRouting?
    weak var listener: AppHomeListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: AppHomePresentable) {
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        
        let widgetViewModels = [
            HomeWidgetModel(
                imageName: "car",
                title: "슈퍼택시",
                tapHandler: { [weak self] in
                    self?.router?.attachTransportHome()
                }
            ),
            HomeWidgetModel(
                imageName: "cart",
                title: "슈퍼마트",
                tapHandler: { 
                    print("슈퍼마트")
                }
            )
        ]
        
        presenter.updateWidget(widgetViewModels.map(HomeWidgetViewModel.init))
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func transportHomeDidTapClose() {
        router?.detachTransportHome()
    }
}
