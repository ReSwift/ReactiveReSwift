//
//  StreamType.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

/// A protocol that denotes a type that sends values over time.
public protocol StreamType {
    /// The type of the values within the `Stream`.
    associatedtype ValueType
    /** The type of the disposable object returned from a subscription.
     If you can't conform the disposable of your choice FRP library to `SubscriptionReferenceType`,
     you can create a struct to contain the disposable and return that instead.
     If your choice FRP library does not provide a disposable type, you can create an empty struct,
     and simply return nil from `subscribe(_:)`.
     */
    associatedtype DisposableType: SubscriptionReferenceType

    /// Register a callback to be called when new values flow down the stream.
    func subscribe(_ function: @escaping (ValueType) -> Void) -> DisposableType?
}
