//
//  Reducer.swift
//  ReactiveReSwift
//
//  Created by Benjamin Encz on 12/14/15.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//

import Foundation

public struct Reducer<State: StateType> {
    private let transform: (Action, State) -> State

    public init(_ transform: @escaping (Action, State) -> State) {
        self.transform = transform
    }

    public init(_ first: Reducer<State>, _ rest: Reducer<State>...) {
        self = rest.reduce(first) {
            $0.concat($1)
        }
    }

    internal func run(action: Action, state: State) -> State {
        return transform(action, state)
    }

    public func concat(_ other: Reducer<State>) -> Reducer<State> {
        return map(other.transform)
    }

    public func map(_ transform: @escaping (Action, State) -> State) -> Reducer<State> {
        return Reducer<State> {
            return transform($0, self.transform($0, $1))
        }
    }
}
