# ReactiveKit

# Setup

You'll need to add the following "glue code" to your application, ideally as `ReactiveReSwiftBridge.swift`:

```swift
import ReactiveKit
import ReactiveReSwift

extension Signal: StreamType {
    public typealias ValueType = Element
    public typealias DisposableType = DisposableWrapper

    public func subscribe(_ function: @escaping (Element) -> Void) -> DisposableWrapper {
        return DisposableWrapper(disposable: observeNext(with: function))
    }
}

extension Property: ObservablePropertyType {
    public typealias ValueType = Value
    public typealias DisposableType = DisposableWrapper

    public func subscribe(_ function: @escaping (Value) -> Void) -> DisposableWrapper {
        return DisposableWrapper(disposable: observeNext(with: function))
    }
}

public struct DisposableWrapper: SubscriptionReferenceType {
    let disposable: Disposable

    public func dispose() {
        disposable.dispose()
    }
}

```

You'll want to use a `Property` as the observable when you create your app's `Store`.

You're all set up!
