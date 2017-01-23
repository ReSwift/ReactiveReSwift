//
//  TestFakes.swift
//  ReactiveReSwift
//
//  Created by Benji Encz on 12/24/15.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//

import Foundation
import ReactiveReSwift

let dispatchQueue = DispatchQueue.global()

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
        return StandardAction(type: SetValueAction.type,
                              payload: ["value": value as AnyObject],
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

let testReducer = Reducer<TestAppState> { action, state in
    switch action {
    case let action as SetValueAction:
        return TestAppState(testValue: action.value)
    default:
        return state
    }
}

let testValueStringReducer = Reducer<TestStringAppState> { action, state in
    switch action {
    case let action as SetValueStringAction:
        return TestStringAppState(testValue: action.value)
    default:
        return state
    }
}

class TestStoreSubscriber<T> {
    var receivedStates: [T] = []
    var subscription: ((T) -> Void)!

    init() {
        subscription = { self.receivedStates.append($0) }
    }
}
