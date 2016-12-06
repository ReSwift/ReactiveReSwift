//
//  SubscriptionReferenceType.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

import Foundation

/// The protocol that disposable types need to conform to.
public protocol SubscriptionReferenceType {
    /// Dispose of the referenced subscription.
    func dispose()
}
