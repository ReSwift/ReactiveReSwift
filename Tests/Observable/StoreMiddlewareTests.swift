//
//  ObservableStoreMiddlewareTests.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 25/11/16.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//

import XCTest
import Foundation
import ReactiveReSwift

// swiftlint:disable function_body_length
class StoreMiddlewareTests: XCTestCase {

    /**
     it can decorate dispatch function
     */
    func testDecorateDispatch() {
        let store = Store(reducer: testValueStringReducer,
            observable: ObservableProperty(TestStringAppState()),
            middleware: Middleware(firstMiddleware, secondMiddleware))

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
        let store = Store(reducer: testValueStringReducer,
            observable: ObservableProperty(TestStringAppState()),
            middleware: Middleware(firstMiddleware, secondMiddleware, dispatchingMiddleware).flatMap { $1 })

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
        let store = Store(reducer: testValueStringReducer,
                                    observable: property,
                                    middleware: stateAccessingMiddleware)

        store.dispatch(SetValueStringAction("Action That Won't Go Through"))

        XCTAssertEqual(store.observable.value.testValue, "Not OK")
    }

    /**
     it middleware should not be executed if the previous middleware returned nil
     */
    func testMiddlewareSkipsReducersWhenPassedNil() {
        let filteringMiddleware1 = Middleware<TestStringAppState>().filter({ _, _ in false }).sideEffect { _, _, _ in XCTFail() }
        let filteringMiddleware2 = Middleware<TestStringAppState>().filter({ _, _ in false }).flatMap { _, _ in XCTFail(); return nil }

        let property = ObservableProperty(TestStringAppState(testValue: "OK"))

        var store = Store(reducer: testValueStringReducer,
                          observable: property,
                          middleware: Middleware(filteringMiddleware1, filteringMiddleware2))
        store.dispatch(SetValueStringAction("Action That Won't Go Through"))

        store = Store(reducer: testValueStringReducer,
                           observable: property,
                           middleware: filteringMiddleware1)
        store.dispatch(SetValueStringAction("Action That Won't Go Through"))

        store = Store(reducer: testValueStringReducer,
                      observable: property,
                      middleware: filteringMiddleware2)
        store.dispatch(SetValueStringAction("Action That Won't Go Through"))
    }

    /**
     it actions should be multiplied via the increase function
     */
    func testMiddlewareMultiplies() {
        let multiplexingMiddleware = Middleware<CounterState>().increase { [$1, $1, $1] }
        let property = ObservableProperty(CounterState(count: 0))
        let store = Store(reducer: increaseByOneReducer,
                          observable: property,
                          middleware: multiplexingMiddleware)
        store.dispatch(NoOpAction())
        XCTAssertEqual(store.observable.value.count, 3)
    }
}
