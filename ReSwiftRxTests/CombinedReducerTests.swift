//
//  CombinedReducerTests.swift
//  ReSwiftRx
//
//  Created by Benjamin Encz on 12/20/15.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//

import XCTest
import ReSwiftRx

class MockReducer: Reducer {

    var calledWithAction: [Action] = []

    func handleAction(action: Action, state: CounterState) -> CounterState {
        calledWithAction.append(action)

        return state
    }

}

class IncreaseByOneReducer: Reducer {
    func handleAction(action: Action, state: CounterState) -> CounterState {
        return CounterState(count: state.count + 1)
    }
}

class IncreaseByTwoReducer: Reducer {
    func handleAction(action: Action, state: CounterState) -> CounterState {
        return CounterState(count: state.count + 2)
    }
}

class CombinedReducerTest: XCTestCase {

    /**
     it calls each of the reducers with the given action exactly once
     */
    func testCallsReducersOnce() {
        let mockReducer1 = MockReducer()
        let mockReducer2 = MockReducer()

        let combinedReducer = CombinedReducer(mockReducer1, mockReducer2)

        _ = combinedReducer._handleAction(
            action: NoOpAction(),
            state: CounterState())

        XCTAssertEqual(mockReducer1.calledWithAction.count, 1)
        XCTAssertEqual(mockReducer2.calledWithAction.count, 1)
        XCTAssert((mockReducer1.calledWithAction.first) is NoOpAction)
        XCTAssert((mockReducer2.calledWithAction.first) is NoOpAction)
    }

    /**
     it combines the results from each individual reducer correctly
     */
    func testCombinesReducerResults() {
        let increaseByOneReducer = IncreaseByOneReducer()
        let increaseByTwoReducer = IncreaseByTwoReducer()

        let combinedReducer = CombinedReducer(increaseByOneReducer, increaseByTwoReducer)

        let newState = combinedReducer._handleAction(
            action: NoOpAction(),
            state: CounterState()) as? CounterState

        XCTAssertEqual(newState?.count, 3)
    }
}
