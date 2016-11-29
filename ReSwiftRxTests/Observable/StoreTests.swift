//
//  ObservableStoreTests.swift
//  ReSwiftRx
//
//  Created by Charlotte Tortorella on 25/11/16.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import XCTest
@testable import ReSwiftRx

class ObservableStoreTests: XCTestCase {

    /**
     it dispatches an Init action when it doesn't receive an initial state
     */
    func testInit() {
        let reducer = MockReducer()
        _ = Store(reducer: reducer,
                  stateType: CounterState.self,
                  observable: ObservableProperty(CounterState()))

        XCTAssert(reducer.calledWithAction.first is ReSwiftInit?)
    }

    /**
     it deinitializes when no reference is held
     */
    func testDeinit() {
        var deInitCount = 0

        autoreleasepool {
            _ = DeInitStore(reducer: TestReducer(),
                                      stateType: TestAppState.self,
                                      observable: ObservableProperty(TestAppState()),
                                      deInitAction: { deInitCount += 1 })
        }

        XCTAssertEqual(deInitCount, 1)
    }

}

// Used for deinitialization test
class DeInitStore<State: StateType>: Store<ObservableProperty<State>> {
    var deInitAction: (() -> Void)?

    deinit {
        deInitAction?()
    }

    required convenience init(
        reducer: AnyReducer,
        stateType: ObservableProperty.ValueType.Type,
        observable: ObservableProperty,
        deInitAction: (() -> Void)?) {
        self.init(reducer: reducer, stateType: stateType, observable: observable, middleware: [])
        self.deInitAction = deInitAction
    }

    required init(reducer: AnyReducer,
                  stateType: ObservableProperty.ValueType.Type,
                  observable: ObservableProperty,
                  middleware: [Middleware]) {
        super.init(reducer: reducer,
                   stateType: stateType,
                   observable: observable,
                   middleware: middleware)
    }
}
