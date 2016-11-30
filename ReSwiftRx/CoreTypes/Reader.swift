//
//  Reader.swift
//  FPExamples
//
//  Created by Charlotte Tortorella on 25/11/16.
//  Copyright © 2016 Charlotte Tortorella. All rights reserved.
//

// swiftlint:disable variable_name
// swiftlint:disable line_length

public typealias DispatchFunction = (Action) -> Void

public struct Reader<State: StateType> {
    private let transform: (State, DispatchFunction, Action) -> Action

    public init(_ transform: @escaping (State, DispatchFunction, Action) -> Action) {
        self.transform = transform
    }

    public init(_ first: Reader<State>, _ rest: Reader<State>...) {
        self = rest.reduce(first) {
            $0.concat($1)
        }
    }

    public func run(state: State, dispatch: DispatchFunction, argument: Action) -> Action {
        return transform(state, dispatch, argument)
    }

    public func concat(_ other: Reader<State>) -> Reader<State> {
        return map(other.transform)
    }

    public func map(_ f: @escaping (State, DispatchFunction, Action) -> Action) -> Reader<State> {
        return Reader<State> { f($0, $1, self.transform($0, $1, $2)) }
    }

    public func flatMap(_ f: @escaping (State, DispatchFunction, Action) -> Reader<State>) -> Reader<State> {
        return Reader<State> { f($0, $1, self.transform($0, $1, $2)).transform($0, $1, $2) }
    }
}
