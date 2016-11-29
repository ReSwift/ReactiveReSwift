//
//  ObservableStoreDispatchTests.swift
//  ReSwiftRx
//
//  Created by Charlotte Tortorella on 11/25/2016.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

import XCTest
import ReSwiftRx

fileprivate typealias StoreTestType = Store<ObservableProperty<TestAppState>>

class ObservableStoreDispatchTests: XCTestCase {
    
    fileprivate var store: StoreTestType!
    var reducer: TestReducer!

    private struct EmptyAction: Action {
    }

    override func setUp() {
        super.setUp()
        reducer = TestReducer()
        store = Store(reducer: reducer,
                                stateType: TestAppState.self,
                                observable: ObservableProperty(TestAppState()))
    }

    /**
     it returns the dispatched action
     */
    func testReturnsDispatchedAction() {
        let action = SetValueAction(10)
        let returnValue = store.dispatch(action)

        XCTAssertEqual((returnValue as? SetValueAction)?.value, action.value)
    }

    /**
     it throws an exception when a reducer dispatches an action
     */
    func testThrowsExceptionWhenReducersDispatch() {
        // Expectation lives in the `DispatchingReducer` class
        let reducer = ObservableDispatchingReducer()
        store = Store(reducer: reducer,
                                stateType: TestAppState.self,
                                observable: ObservableProperty(TestAppState()))
        reducer.store = store
        store.dispatch(SetValueAction(10))
    }

    /**
     it subscribes to the property we pass in and dispatches any new values
     */
    func testLiftingWorksAsExpected() {
        let property = ObservableProperty(SetValueAction(10))
        store = Store(reducer: reducer,
                                stateType: TestAppState.self,
                                observable: ObservableProperty(TestAppState()))
        store.lift(property)
        property.value = SetValueAction(20)
        XCTAssertEqual(store.observable.value.testValue, 20)
    }
}

// Needs to be class so that shared reference can be modified to inject store
class ObservableDispatchingReducer: XCTestCase, Reducer {
    fileprivate var store: StoreTestType? = nil

    func handleAction(action: Action, state: TestAppState) -> TestAppState {
        expectFatalError {
            self.store?.dispatch(SetValueAction(20))
        }
        return state
    }
}
