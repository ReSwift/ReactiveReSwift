//
//  Store.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 11/17/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

import Foundation

open class Store<ObservableProperty: ObservablePropertyType> where ObservableProperty.ValueType: StateType {

    public typealias StoreMiddleware = Middleware<ObservableProperty.ValueType>
    public typealias StoreReducer = Reducer<ObservableProperty.ValueType>

    public private(set) var observable: ObservableProperty
    private let middleware: StoreMiddleware
    private let reducer: StoreReducer
    private let disposeBag = SubscriptionReferenceBag()

    public required init(reducer: StoreReducer, observable: ObservableProperty, middleware: StoreMiddleware = Middleware()) {
        self.reducer = reducer
        self.observable = observable
        self.middleware = middleware
    }

    public func dispatch(_ actions: Action...) {
        actions.forEach { action in
            middleware.transform({ self.observable.value }, self.dispatch, action).forEach { action in
                observable.value = reducer.transform(action, observable.value)
            }
        }
    }

    public func dispatch<S: StreamType>(_ stream: S) where S.ValueType: Action {
        disposeBag += stream.subscribe { [unowned self] action in
            self.dispatch(action)
        }
    }
}
