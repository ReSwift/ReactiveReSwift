//
//  RxTests.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 25/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

@testable import ReactiveReSwift
import XCTest

class RxTests: XCTestCase {

    func testObservablePropertySendsNewValues() {
        let values = (10, 20, 30)
        var receivedValue: Int?
        let property = ObservableProperty(values.0)
        property.subscribe {
            receivedValue = $0
        }
        XCTAssertEqual(receivedValue, values.0)
        property.value = values.1
        XCTAssertEqual(receivedValue, values.1)
        property.value = values.2
        XCTAssertEqual(receivedValue, values.2)
    }

    func testObservablePropertyDisposesOfReferences() {
        let property = ObservableProperty(())
        let reference = property.subscribe({})
        XCTAssertEqual(property.subscriptions.count, 1)
        reference?.dispose()
        XCTAssertEqual(property.subscriptions.count, 0)
    }

    func testSubscriptionBagDisposesOfReferences() {
        let property = ObservableProperty(())
        let bag = SubscriptionReferenceBag(property.subscribe({}))
        bag += property.subscribe({})
        XCTAssertEqual(property.subscriptions.count, 2)
        bag.dispose()
        XCTAssertEqual(property.subscriptions.count, 0)
    }

    func testThatDisposingOfAReferenceTwiceIsOkay() {
        let property = ObservableProperty(())
        let reference = property.subscribe({})
        reference?.dispose()
        reference?.dispose()
    }

}
