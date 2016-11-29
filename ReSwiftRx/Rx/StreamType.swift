//
//  StreamType.swift
//  ReSwiftRx
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

import Foundation

public protocol StreamType {
    associatedtype ValueType
    func subscribe(_ function: @escaping (ValueType) -> Void) -> SubscriptionReferenceType?
}
