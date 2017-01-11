# RxSwift

# Setup

You'll need to add the following "glue code" to your application, ideally as `ReactiveReSwiftBridge.swift`:

```swift
import ReactiveReSwift
import RxSwift

extension Variable: ObservablePropertyType {
    public typealias ValueType = Element
    public typealias DisposableType = DisposableWrapper

    public func subscribe(_ function: @escaping (Element) -> Void) -> DisposableWrapper? {
        return DisposableWrapper(disposable: asObservable().subscribe(onNext: function))
    }
}

extension Observable: StreamType {
    public typealias ValueType = Element
    public typealias DisposableType = DisposableWrapper

    public func subscribe(_ function: @escaping (Element) -> Void) -> DisposableWrapper? {
        return DisposableWrapper(disposable: subscribe(onNext: function))
    }
}

public struct DisposableWrapper: SubscriptionReferenceType {
    let disposable: Disposable

    public func dispose() {
        disposable.dispose()
    }
}
```

You'll want to use a `Variable` as the observable when you create your app's `Store`.

You're all set up!
