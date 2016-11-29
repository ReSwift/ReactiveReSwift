//
//  ObservablePropertyType.swift
//  ReSwiftRx
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

public protocol ObservablePropertyType: StreamType {
    var value: ValueType { get set }
}
