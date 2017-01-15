//
//  ObservableStoreDispatchTests.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 11/25/2016.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

import XCTest
import ReactiveReSwift

fileprivate typealias StoreTestType = Store<ObservableProperty<TestAppState>>

class ObservableStoreDispatchTests: XCTestCase {

    fileprivate var store: StoreTestType!
    var reducer: Reducer<TestAppState>!

    private struct EmptyAction: Action {
    }

    override func setUp() {
        super.setUp()
        reducer = testReducer
    }

    /**
     it subscribes to the property we pass in and dispatches any new values
     */
    func testLiftingWorksAsExpected() {
        let property = ObservableProperty(SetValueAction(10))
        store = Store(reducer: reducer,
                      observable: ObservableProperty(TestAppState()))
        store.dispatch(property)
        property.value = SetValueAction(20)
        XCTAssertEqual(store.observable.value.testValue, 20)
    }
}
