//
//  ReducerTests.swift
//  ReactiveReSwift
//
//  Created by Benjamin Encz on 12/20/15.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//

import XCTest
@testable import ReactiveReSwift

class MockReducerContainer {

    var calledWithAction: [Action] = []
    var reducer: Reducer<CounterState>!

    init() {
        reducer = { action, state in
            self.calledWithAction.append(action)
            return state
        }
    }
}

let increaseByOneReducer: Reducer<CounterState> = { action, state in
    CounterState(count: state.count + 1)
}

let increaseByTwoReducer: Reducer<CounterState> = { action, state in
    CounterState(count: state.count + 2)
}

class ReducerTests: XCTestCase {

    /**
     it calls each of the reducers with the given action exactly once
     */
    func testCallsReducersOnce() {
        let mockReducer1 = MockReducerContainer()
        let mockReducer2 = MockReducerContainer()
        let combinedReducer = concatReducers(mockReducer1.reducer, mockReducer2.reducer)

        _ = combinedReducer(NoOpAction(), CounterState())

        XCTAssertEqual(mockReducer1.calledWithAction.count, 1)
        XCTAssertEqual(mockReducer2.calledWithAction.count, 1)
        XCTAssert((mockReducer1.calledWithAction.first) is NoOpAction)
        XCTAssert((mockReducer2.calledWithAction.first) is NoOpAction)
    }

    /**
     it combines the results from each individual reducer correctly
     */
    func testCombinesReducerResults() {
        let combinedReducer = concatReducers(first: increaseByOneReducer, rest: [increaseByTwoReducer])
        let newState = combinedReducer(NoOpAction(), CounterState())

        XCTAssertEqual(newState.count, 3)
    }
}
