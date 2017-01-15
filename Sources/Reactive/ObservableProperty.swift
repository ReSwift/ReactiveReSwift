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
public class ObservableProperty<ValueType>: ObservablePropertyType {
    public typealias DisposableType = ObservablePropertySubscriptionReferenceType
    public typealias ObservablePropertySubscriptionReferenceType = ObservablePropertySubscriptionReference<ValueType>
    internal var subscriptions = [ObservablePropertySubscriptionReferenceType : (ValueType) -> ()]()
    private var subscriptionToken: Int = 0
    private var retainReference: ObservableProperty<ValueType>?
    fileprivate var disposeBag = SubscriptionReferenceBag()
    private var queue: DispatchQueue?
    public var value: ValueType {
        didSet {
            let closure = {
                self.subscriptions.forEach { $0.value(self.value) }
            }
            queue?.async(execute: closure) ?? closure()
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

    public func map<U>(_ transform: @escaping (ValueType) -> U) -> ObservableProperty<U> {
        let property = ObservableProperty<U>(transform(value))
        property.disposeBag += subscribe { value in
            property.value = transform(value)
        }
        return property
    }

    public func distinct(_ equal: @escaping (ValueType, ValueType) -> Bool) -> ObservableProperty<ValueType> {
        let property = ObservableProperty(value)
        property.disposeBag += subscribe { value in
            if !equal(value, property.value) {
                property.value = value
            }
        }
        return property
    }

    public func deliveredOn(_ queue: DispatchQueue) -> ObservableProperty<ValueType> {
        let property = map({ $0 })
        property.queue = queue
        return property
    }

    internal func unsubscribe(reference: ObservablePropertySubscriptionReferenceType) {
        subscriptions.removeValue(forKey: reference)
        if subscriptions.isEmpty {
            retainReference = nil
        }
    }
}

extension ObservableProperty where ValueType: Equatable {
    public func distinct() -> ObservableProperty<ValueType> {
        return distinct(==)
    }
}
