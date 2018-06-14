//
//  Store.swift
//  ReactiveReSwift
//
//  Created by Charlotte Tortorella on 11/17/16.
//  Copyright © 2016 Benjamin Encz. All rights reserved.
//

import Foundation

open class Store<ObservableProperty: ObservablePropertyType> {

    public typealias State = ObservableProperty.ValueType
    public typealias StoreMiddleware = Middleware<State>
    public typealias StoreReducer = Reducer<State>

    open private(set) var observable: ObservableProperty
    private let middleware: StoreMiddleware
    private let reducer: StoreReducer
    private let disposeBag = SubscriptionReferenceBag()

    public required init(reducer: @escaping StoreReducer, observable: ObservableProperty, middleware: StoreMiddleware = Middleware()) {
        self.reducer = reducer
        self.observable = observable
        self.middleware = middleware
    }

    open func dispatch(_ actions: Action...) {
        actions.forEach { action in
            let dispatchFunction: (Action...) -> Void = { [weak self] (actions: Action...) in
                actions.forEach { self?.dispatch($0) }
            }
            middleware.transform({ self.observable.value }, dispatchFunction, action).forEach { action in
                observable.value = reducer(action, observable.value)
            }
        }
    }

    @discardableResult
    open func dispatch<S: StreamType>(_ stream: S) -> SubscriptionReferenceType where S.ValueType: Action {
        let disposable = stream.subscribe { [unowned self] action in
            self.dispatch(action)
        }
        disposeBag += disposable
        return disposable
    }
}
