//
//  Middleware.swift
//  FPExamples
//
//  Created by Charlotte Tortorella on 25/11/16.
//  Copyright © 2016 Charlotte Tortorella. All rights reserved.
//

// swiftlint:disable line_length

public struct Middleware<State: StateType> {
    public typealias DispatchFunction = (Action) -> Void
    public typealias GetState = () -> State

    private let transform: (GetState, DispatchFunction, Action) -> Action

    public init(_ transform: @escaping (GetState, DispatchFunction, Action) -> Action) {
        self.transform = transform
    }

    public init(_ first: Middleware<State>, _ rest: Middleware<State>...) {
        self = rest.reduce(first) {
            $0.concat($1)
        }
    }

    internal func run(state: GetState, dispatch: DispatchFunction, argument: Action) -> Action {
        return transform(state, dispatch, argument)
    }

    public func concat(_ other: Middleware<State>) -> Middleware<State> {
        return map(other.transform)
    }

    public func map(_ transform: @escaping (GetState, DispatchFunction, Action) -> Action) -> Middleware<State> {
        return Middleware<State> {
            transform($0, $1, self.transform($0, $1, $2))
        }
    }
}
