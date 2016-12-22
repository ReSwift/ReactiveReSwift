//
//  ObservablePropertyType.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 29/11/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

/**
 A protocol that denotes a type that stores a value and
 sends updates when the underlying value changes.
 */
public protocol ObservablePropertyType: StreamType {
    /** 
     The underlying value that triggers new values to 
     be sent down the stream when it changes.
     */
    var value: ValueType { get set }
}
