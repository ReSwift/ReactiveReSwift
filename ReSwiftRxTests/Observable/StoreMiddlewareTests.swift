//
//  ObservableStoreMiddlewareTests.swift
//  ReSwiftRx
//
//  Created by Charlotte Tortorella on 25/11/16.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//

import XCTest
import ReSwiftRx

// swiftlint:disable function_body_length
class StoreMiddlewareTests: XCTestCase {

    /**
     it can decorate dispatch function
     */
    func testDecorateDispatch() {
        let store = Store(reducer: TestValueStringReducer(),
            stateType: TestStringAppState.self,
            observable: ObservableProperty(TestStringAppState()),
            middleware: Reader(firstReader, secondReader))

        let subscriber = TestStoreSubscriber<TestStringAppState>()
        store.observable.subscribe(subscriber.subscription)

        let action = SetValueStringAction("OK")
        store.dispatch(action)

        XCTAssertEqual(store.observable.value.testValue, "OK First Middleware Second Middleware")
    }

    /**
     it can dispatch actions
     */
    func testCanDispatch() {
        let store = Store(reducer: TestValueStringReducer(),
            stateType: TestStringAppState.self,
            observable: ObservableProperty(TestStringAppState()),
            middleware: Reader(firstReader, secondReader, dispatchingReader))

        let subscriber = TestStoreSubscriber<TestStringAppState>()
        store.observable.subscribe(subscriber.subscription)

        let action = SetValueAction(10)
        store.dispatch(action)

        XCTAssertEqual(store.observable.value.testValue, "10 First Middleware Second Middleware")
    }

    /**
     it middleware can access the store's state
     */
    func testMiddlewareCanAccessState() {
        let property = ObservableProperty(TestStringAppState(testValue: "OK"))
        let store = Store(reducer: TestValueStringReducer(),
                                    stateType: TestStringAppState.self,
                                    observable: property,
                                    middleware: stateAccessingReader)

        store.dispatch(SetValueStringAction("Action That Won't Go Through"))

        XCTAssertEqual(store.observable.value.testValue, "Not OK")
    }
}
