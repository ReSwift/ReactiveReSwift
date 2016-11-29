//
//  ObservableSubscriptionReference.swift
//  ReSwiftRx
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

internal struct ObservableSubscriptionReference<T> {
    internal let key: String
    internal weak var stream: ObservableProperty<T>?

    internal init(key: String, stream: ObservableProperty<T>) {
        self.key = key
        self.stream = stream
    }
}

extension ObservableSubscriptionReference: SubscriptionReferenceType {
    func dispose() {
        stream?.unsubscribe(reference: self)
    }
}

extension ObservableSubscriptionReference: Equatable, Hashable {
    var hashValue: Int {
        return key.hash
    }

    static func == <T>(lhs: ObservableSubscriptionReference<T>,
                        rhs: ObservableSubscriptionReference<T>) -> Bool {
        return lhs.key == rhs.key
    }
}
