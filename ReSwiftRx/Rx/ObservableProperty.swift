//
//  ObservableProperty.swift
//  ReSwiftRx
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

public final class ObservableProperty<ValueType>: ObservablePropertyType {
    public typealias ObservableSubscriptionReferenceType =
        ObservableSubscriptionReference<ValueType>
    internal var subscriptions = [ObservableSubscriptionReferenceType : (ValueType) -> Void]()
    private var subscriptionToken: Int = 0
    public var value: ValueType {
        didSet {
            subscriptions.forEach { $0.value(value) }
        }
    }
    
    public init(_ value: ValueType) {
        self.value = value
    }
    
    @discardableResult
    public func subscribe(_ function: @escaping (ValueType) -> Void) -> SubscriptionReferenceType? {
        defer { subscriptionToken += 1 }
        let reference = ObservableSubscriptionReferenceType(key: String(subscriptionToken),
                                                            stream: self)
        subscriptions.updateValue(function,
                                  forKey: reference)
        return reference
    }
    
    internal func unsubscribe(reference: ObservableSubscriptionReferenceType) {
        subscriptions.removeValue(forKey: reference)
    }
}
