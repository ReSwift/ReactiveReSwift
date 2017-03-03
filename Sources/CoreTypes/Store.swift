//
//  Store.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 11/17/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

import Foundation

open class Store<ObservableProperty: ObservablePropertyType> {

    public typealias StoreMiddleware = Middleware<ObservableProperty.ValueType>
    public typealias StoreReducer = Reducer<ObservableProperty.ValueType>

    open private(set) var observable: ObservableProperty
    private let middleware: StoreMiddleware
    private let reducer: StoreReducer
    private let disposeBag = SubscriptionReferenceBag()

    public required init(reducer: @escaping StoreReducer, observable: ObservableProperty, middleware: StoreMiddleware = Middleware()) {
        self.reducer = reducer
        self.observable = observable
        self.middleware = middleware
    }

    public func dispatch(_ actions: Action...) {
        actions.forEach { action in
            let dispatchFunction: (Action...) -> Void = { [weak self] (actions: Action...) in
                actions.forEach { self?.dispatch($0) }
            }
            middleware.transform({ self.observable.value }, dispatchFunction, action).forEach { action in
                observable.value = reducer(action, observable.value)
            }
        }
    }

    public func dispatch<S: StreamType>(_ stream: S) where S.ValueType: Action {
        disposeBag += stream.subscribe { [unowned self] action in
            self.dispatch(action)
        }
    }
}
