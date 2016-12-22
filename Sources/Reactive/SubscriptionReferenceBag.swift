//
//  SubscriptionReferenceBag.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

/**
 A class to hold subscriptions to `SubscriptionReferenceType`.
 Very similar to `autoreleasepool` but specifically for disposable types.
 Disposes of all held subscriptions when deallocated or `dispose()` is called.
 */
public class SubscriptionReferenceBag {
    fileprivate var references: [SubscriptionReferenceType] = []

    /// Initialise an empty bag.
    public init() {
    }

    /// Initialise the bag with an array of subscription references.
    public init(_ references: SubscriptionReferenceType?...) {
        self.references = references.flatMap({ $0 })
    }

    deinit {
        dispose()
    }

    /// Add a new reference to the bag if the reference is not `nil`.
    public func addReference(reference: SubscriptionReferenceType?) {
        if let reference = reference {
            references.append(reference)
        }
    }

    /// Add a new reference to the bag if the reference is not `nil`.
    public static func += (lhs: SubscriptionReferenceBag, rhs: SubscriptionReferenceType?) {
        lhs.addReference(reference: rhs)
    }
}

extension SubscriptionReferenceBag: SubscriptionReferenceType {
    /// Dispose of all subscriptions in the bag.
    public func dispose() {
        references.forEach { $0.dispose() }
        references = []
    }
}
