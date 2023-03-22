//
//  TopupInteractorTests.swift
//  MiniSuperApp
//
//  Created by 주진홍 on 2023/03/21.
//

@testable import TopupImp
import XCTest

final class TopupInteractorTests: XCTestCase {
    
    private var sut: TopupInteractor!
    private var dependency: TopupDependencyMock!
    
    
    
    override func setUp() {
        super.setUp()
        self.dependency = TopupDependencyMock()
        sut = TopupInteractor(dependency: self.dependency)
    }
    
    // MARK: - Tests
    
    func test_exampleObservable_callsRouterOrListener_exampleProtocol() {
        // This is an example of an interactor test case.
        // Test your interactor binds observables and sends messages to router or listener.
    }
}
