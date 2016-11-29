//
//  TestFakes.swift
//  ReSwift
//
//  Created by Benji Encz on 12/24/15.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//

import Foundation
import ReSwift

let emptyAction = "EMPTY_ACTION"

struct CounterState: StateType {
    var count: Int = 0
}

struct TestAppState: StateType {
    var testValue: Int?
}

struct TestStringAppState: StateType {
    var testValue: String?
}

struct SetValueAction: StandardActionConvertible {

    let value: Int
    static let type = "SetValueAction"

    init (_ value: Int) {
        self.value = value
    }

    init(_ standardAction: StandardAction) {
        self.value = standardAction.payload!["value"] as! Int
    }

    func toStandardAction() -> StandardAction {
        return StandardAction(type: SetValueAction.type, payload: ["value": value as AnyObject],
                                isTypedAction: true)
    }

}

struct SetValueStringAction: StandardActionConvertible {

    var value: String
    static let type = "SetValueStringAction"

    init (_ value: String) {
        self.value = value
    }

    init(_ standardAction: StandardAction) {
        self.value = standardAction.payload!["value"] as! String
    }

    func toStandardAction() -> StandardAction {
        return StandardAction(type: SetValueStringAction.type,
                              payload: ["value": value as AnyObject],
                              isTypedAction: true)
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
