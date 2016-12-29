//
//  ObservableStoreTests.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 25/11/16.
//  Copyright © 2015 DigiTales. All rights reserved.
//

import XCTest
@testable import ReactiveReSwift

class ObservableStoreTests: XCTestCase {

    /**
     it deinitializes when no reference is held
     */
    func testDeinit() {
        var deInitCount = 0

        autoreleasepool {
            _ = DeInitStore(reducer: testReducer,
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

    convenience init(reducer: Reducer<ObservableProperty.ValueType>,
                  stateType: ObservableProperty.ValueType.Type,
                  observable: ObservableProperty,
                  middleware: Middleware<ObservableProperty.ValueType> = Middleware(),
                  dispatchQueue: DispatchQueue = DispatchQueue.main,
                  deInitAction: @escaping () -> Void) {
        self.init(reducer: reducer,
                   stateType: stateType,
                   observable: observable,
                   middleware: middleware,
                   dispatchQueue: dispatchQueue)
        self.deInitAction = deInitAction
    }

    required init(reducer: Reducer<ObservableProperty.ValueType>,
                  stateType: ObservableProperty.ValueType.Type,
                  observable: ObservableProperty,
                  middleware: Middleware<ObservableProperty.ValueType>,
                  dispatchQueue: DispatchQueue) {
        super.init(reducer: reducer,
                   stateType: stateType,
                   observable: observable,
                   middleware: middleware,
                   dispatchQueue: dispatchQueue)
    }
}
