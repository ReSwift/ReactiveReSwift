//
//  ObservableProperty.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

/**
 This class is the default implementation of the `ObservablePropertyType` protocol. It is recommended
 that you do not use this observable and instead use an observable from a full FRP library.
 The existence of this class is to make ReactiveReSwift fully functional without third party libararies.
 */
public final class ObservableProperty<ValueType>: ObservablePropertyType {
    public typealias DisposableType = ObservablePropertySubscriptionReferenceType
    public typealias ObservablePropertySubscriptionReferenceType = ObservablePropertySubscriptionReference<ValueType>
    internal var subscriptions = [ObservablePropertySubscriptionReferenceType : (ValueType) -> ()]()
    private var subscriptionToken: Int = 0
    private var retainReference: ObservableProperty<ValueType>?
    public var value: ValueType {
        didSet {
            subscriptions.forEach { $0.value(value) }
        }
    }

    public init(_ value: ValueType) {
        self.value = value
    }

    @discardableResult
    public func subscribe(_ function: @escaping (ValueType) -> Void) -> DisposableType? {
        defer { subscriptionToken += 1 }
        retainReference = self
        function(value)
        let reference = ObservablePropertySubscriptionReferenceType(key: String(subscriptionToken), stream: self)
        subscriptions.updateValue(function, forKey: reference)
        return reference
    }

    internal func unsubscribe(reference: ObservablePropertySubscriptionReferenceType) {
        subscriptions.removeValue(forKey: reference)
        if subscriptions.count == 0 {
            retainReference = nil
        }
    }
}
