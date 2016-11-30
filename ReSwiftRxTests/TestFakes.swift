//
//  TestFakes.swift
//  ReSwiftRx
//
//  Created by Benji Encz on 12/24/15.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//

import Foundation
import ReSwiftRx

struct NoOpAction: Action {}

struct CounterState: StateType {
    var count: Int = 0
}

struct TestAppState: StateType {
    var testValue: Int?
}

struct TestStringAppState: StateType {
    var testValue: String?
}

struct SetValueAction: Action {

    let value: Int

    init (_ value: Int) {
        self.value = value
    }

}

struct SetValueStringAction: Action {

    var value: String

    init (_ value: String) {
        self.value = value
    }

}

struct TestReducer: Reducer {
    func handleAction(action: Action, state: TestAppState) -> TestAppState {
        switch action {
        case let action as SetValueAction:
            return TestAppState(testValue: action.value)
        default:
            return state
        }
    }
}

struct TestValueStringReducer: Reducer {
    func handleAction(action: Action, state: TestStringAppState) -> TestStringAppState {
        switch action {
        case let action as SetValueStringAction:
            return TestStringAppState(testValue: action.value)
        default:
            return state
        }
    }
}

class TestStoreSubscriber<T> {
    var receivedStates: [T] = []
    var subscription: (T) -> Void = { _ in }

    init() {
        subscription = { self.receivedStates.append($0) }
    }

    func newState(state: T) {
        receivedStates.append(state)
    }
}
