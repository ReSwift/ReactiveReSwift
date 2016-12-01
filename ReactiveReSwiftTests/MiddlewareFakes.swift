//
//  MiddlewareFakes.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 25/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

import ReactiveReSwift

let firstMiddleware = Middleware<TestStringAppState> { state, dispatch, action in
    if let action = action as? SetValueStringAction {
        return SetValueStringAction(action.value + " First Middleware")
    }
    return action
}

let secondMiddleware = Middleware<TestStringAppState> { state, dispatch, action in
    if let action = action as? SetValueStringAction {
        return SetValueStringAction(action.value + " Second Middleware")
    }
    return action
}

let dispatchingMiddleware = Middleware<TestStringAppState> { state, dispatch, action in
    if let action = action as? SetValueAction {
        dispatch(SetValueStringAction("\(action.value)"))
        return nil
    }
    return action
}

let stateAccessingMiddleware = Middleware<TestStringAppState> { state, dispatch, action in
    if let action = action as? SetValueStringAction {
        //Avoid endless recursion by checking if we've exactly this action
        if state().testValue == "OK" && action.value != "Not OK" {
            dispatch(SetValueStringAction("Not OK"))
            //Swallow the action
            return nil
        }
    }
    return action
}
