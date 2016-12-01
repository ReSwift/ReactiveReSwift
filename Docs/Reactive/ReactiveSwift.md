# ReactiveSwift

# Setup

You'll need to add the following "glue code" to your application, ideally as `ReactiveReSwiftBridge.swift`:

```swift
import ReactiveReSwift
import ReactiveSwift

extension MutableProperty: ObservablePropertyType {
    public typealias ValueType = Value
    public typealias DisposableType = AnyDisposable

    @discardableResult
    public func subscribe(_ function: @escaping (Value) -> Void) -> AnyDisposable? {
        let disposable = self.producer.on(value: function).start()
        return AnyDisposable(disposable)
    }
}

extension Signal: StreamType {
    public typealias ValueType = Value
    public typealias DisposableType = AnyDisposable

    @discardableResult
    public func subscribe(_ function: @escaping (Value) -> Void) -> AnyDisposable? {
        let disposable = self.observe { event in
            if case let .value(value) = event {
                function(value)
            }
        }
        return disposable.map { AnyDisposable($0) }
    }
}

extension SignalProducer: StreamType {
    public typealias ValueType = Value
    public typealias DisposableType = AnyDisposable

    @discardableResult
    public func subscribe(_ function: @escaping (Value) -> Void) -> AnyDisposable? {
        return AnyDisposable(self.on(value: function).start())
    }
}

extension AnyDisposable: SubscriptionReferenceType {}
```

This code conforms ReactiveSwift's types to the protocols used in ReactiveReSwift.

To create a `mainStore` with ReactiveSwift you'll need to use a MutableProperty as observable.

Here's an example:
```swift
let mainStore = Store(
    reducer: appReducer,
    stateType: AppState.self,
    observable: MutableProperty(AppState(counter: 0))
)
```

That's it, you're all set up.
