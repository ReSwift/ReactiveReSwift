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
        store = Store(reducer: reducer,
                                stateType: TestAppState.self,
                                observable: ObservableProperty(TestAppState()))
    }

    /**
     it throws an exception when a reducer dispatches an action
     */
    func testThrowsExceptionWhenReducersDispatch() {
        // Expectation lives in the `DispatchingReducer` class
        let reducerContainer = ObservableDispatchingReducer()
        reducerContainer.setUp()
        store = Store(reducer: reducerContainer.reducer,
                                stateType: TestAppState.self,
                                observable: ObservableProperty(TestAppState()))
        reducerContainer.store = store
        store.dispatch(SetValueAction(10))
    }

    /**
     it subscribes to the property we pass in and dispatches any new values
     */
    func testLiftingWorksAsExpected() {
        let property = ObservableProperty(SetValueAction(10))
        store = Store(reducer: reducer,
                      stateType: TestAppState.self,
                      observable: ObservableProperty(TestAppState()),
                      dispatchQueue: dispatchQueue)
        store.dispatch(property)
        property.value = SetValueAction(20)
        dispatchQueue.sync {
            XCTAssertEqual(store.observable.value.testValue, 20)
        }
    }
}

// Needs to be class so that shared reference can be modified to inject store
class ObservableDispatchingReducer: XCTestCase {
    fileprivate var store: StoreTestType? = nil
    fileprivate var reducer: Reducer<TestAppState>!

    override func setUp() {
        super.setUp()
        reducer = Reducer { _, state in
            self.expectFatalError {
                self.store?.dispatch(SetValueAction(20))
            }
            return state
        }
    }
}
