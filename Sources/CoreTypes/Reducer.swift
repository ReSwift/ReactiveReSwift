//
//  Reducer.swift
//  ReactiveReSwift
//
//  Created by Benjamin Encz on 12/14/15.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//

import Foundation

public typealias Reducer<State> = (_ action: Action, _ state: State) -> State

public func concatReducers<State>(_ first: @escaping Reducer<State>, _ rest: Reducer<State>...) -> Reducer<State> {
    return concatReducers(first: first, rest: rest)
}

public func concatReducers<State>(first: @escaping Reducer<State>, rest: [Reducer<State>]) -> Reducer<State> {
    return { action, state in
        rest.reduce(first(action, state)) { state, reducer in
            reducer(action, state)
        }
    }
}
