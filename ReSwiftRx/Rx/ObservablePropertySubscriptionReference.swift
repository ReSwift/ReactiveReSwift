//
//  ObservablePropertySubscriptionReference.swift
//  ReSwiftRx
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

internal struct ObservablePropertySubscriptionReference<T> {
    internal let key: String
    internal weak var stream: ObservableProperty<T>?

    internal init(key: String, stream: ObservableProperty<T>) {
        self.key = key
        self.stream = stream
    }
}

extension ObservablePropertySubscriptionReference: SubscriptionReferenceType {
    func dispose() {
        stream?.unsubscribe(reference: self)
    }
}

extension ObservablePropertySubscriptionReference: Equatable, Hashable {
    var hashValue: Int {
        return key.hash
    }

    static func == <T>(lhs: ObservablePropertySubscriptionReference<T>,
                        rhs: ObservablePropertySubscriptionReference<T>) -> Bool {
        return lhs.key == rhs.key
    }
}
