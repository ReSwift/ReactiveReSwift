# CwlSignal

# Setup

You'll need to add the following "glue code" to your application, ideally as `ReactiveReSwiftBridge.swift`:

```swift
import ReactiveReSwift
import CwlSignal

extension Signal: StreamType {
    public typealias ValueType = T
    public typealias DisposableType = DisposableWrapper<T>

    public func subscribe(_ function: @escaping (T) -> Void) -> DisposableWrapper<T>? {
        return DisposableWrapper(disposable: subscribeValues(handler: function))
    }
}

public struct DisposableWrapper<T>: SubscriptionReferenceType {
    let disposable: SignalEndpoint<T>
    
    public func dispose() {
        disposable.cancel()
    }
}

extension ObservableProperty {
    func signal() -> Signal<ValueType> {
        let (input, signal) = Signal<ValueType>.create()
        let disposable = subscribe { input.send(value: $0) }
        return signal.onDeactivate {
            disposable?.dispose()
        }
    }
}
```

Since CwlSignal doesn't have a property type, you'll need to use the inbuilt `ObservableProperty` type when making your app's `Store`.

You're all set up!
