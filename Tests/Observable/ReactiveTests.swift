//
//  RxTests.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 25/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

@testable import ReactiveReSwift
import XCTest

class ReactiveTests: XCTestCase {

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

    func testObservablePropertyMapsValues() {
        let values = (10, 20, 30)
        var receivedValue: Int?
        let property = ObservableProperty(values.0)
        property.map { $0 * 10 }.subscribe {
            receivedValue = $0
        }
        XCTAssertEqual(receivedValue, values.0 * 10)
        property.value = values.1
        XCTAssertEqual(receivedValue, values.1 * 10)
        property.value = values.2
        XCTAssertEqual(receivedValue, values.2 * 10)
    }

    func testObservablePropertyFiltersValues() {
        let values = [10, 10, 20, 20, 30, 30, 30]
        var lastReceivedValue: Int?
        var receivedValues: [Int] = []
        let property = ObservableProperty(10)
        property.distinct().subscribe {
            XCTAssertNotEqual(lastReceivedValue, $0)
            lastReceivedValue = $0
            receivedValues += [$0]
        }
        values.forEach { property.value = $0 }
        XCTAssertEqual(receivedValues, [10, 20, 30])
    }

    func testObservablePropertyDisposesOfReferences() {
        let property = ObservableProperty(())
        let reference = property.subscribe({})
        XCTAssertEqual(property.subscriptions.count, 1)
        reference?.dispose()
        XCTAssertEqual(property.subscriptions.count, 0)
    }

    func testSubscriptionBagDisposesOfReferences() {
        let property = ObservableProperty(()).deliveredOn(DispatchQueue.global())
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
