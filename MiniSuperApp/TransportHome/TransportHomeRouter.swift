//
//  TransportHomeRouter.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/02/21.
//

import ModernRIBs

protocol TransportHomeInteractable: Interactable {
    var router: TransportHomeRouting? { get set }
    var listener: TransportHomeListener? { get set }
}

protocol TransportHomeViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class TransportHomeRouter: ViewableRouter<TransportHomeInteractable, TransportHomeViewControllable>, TransportHomeRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: TransportHomeInteractable, viewController: TransportHomeViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
