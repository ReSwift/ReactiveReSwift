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

    convenience init(reducer: Reducer<ObservableProperty<State>.ValueType>,
                  observable: ObservableProperty<State>,
                  middleware: Middleware<ObservableProperty<State>.ValueType> = Middleware(),
                  deInitAction: @escaping () -> Void) {
        self.init(reducer: reducer,
                   observable: observable,
                   middleware: middleware)
        self.deInitAction = deInitAction
    }

    required init(reducer: Reducer<ObservableProperty<State>.ValueType>,
                  observable: ObservableProperty<State>,
                  middleware: Middleware<ObservableProperty<State>.ValueType>) {
        super.init(reducer: reducer,
                   observable: observable,
                   middleware: middleware)
    }
}
