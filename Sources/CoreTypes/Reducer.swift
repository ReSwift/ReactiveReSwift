//
//  Reducer.swift
//  ReactiveReSwift
//
//  Created by Benjamin Encz on 12/14/15.
//  Copyright © 2015 Benjamin Encz. All rights reserved.
//

import Foundation

/**
 Reducer is a structure that allows you to modify the current state
 by reducing actions.
 */
public struct Reducer<State: StateType> {
    internal let transform: (Action, State) -> State

    /**
     Initialises the `Reducer` with a transformative function.
     
     - parameter transform: The function that will be able to modify passed state.
     */
    public init(_ transform: @escaping (Action, State) -> State) {
        self.transform = transform
    }

    /**
     Initialises the `Reducer` by concatenating the transformative functions from
     the `Reducer`s that were passed in.
     */
    public init(_ first: Reducer<State>, _ rest: Reducer<State>...) {
        self = rest.reduce(first) {
            $0.concat($1)
        }
    }

    /// Concatenates the transform function of the passed `Reducer` onto the callee's transform.
    public func concat(_ other: Reducer<State>) -> Reducer<State> {
        return map(other.transform)
    }

    /// Concatenates the transform function onto the callee's transform.
    public func map(_ transform: @escaping (Action, State) -> State) -> Reducer<State> {
        return Reducer<State> {
            return transform($0, self.transform($0, $1))
        }
    }
}
