//
//  SubscriptionReferenceBag.swift
//  ReSwiftRx
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

public class SubscriptionReferenceBag {
    fileprivate var references: [SubscriptionReferenceType] = []

    public init() {
    }

    public init(_ references: SubscriptionReferenceType?...) {
        self.references = references.flatMap({ $0 })
    }

    deinit {
        dispose()
    }

    public func addReference(reference: SubscriptionReferenceType?) {
        if let reference = reference {
            references.append(reference)
        }
    }

    public static func += (lhs: SubscriptionReferenceBag, rhs: SubscriptionReferenceType?) {
        lhs.addReference(reference: rhs)
    }
}

extension SubscriptionReferenceBag: SubscriptionReferenceType {
    public func dispose() {
        references.forEach { $0.dispose() }
        references = []
    }
}
