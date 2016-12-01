# RxSwift

# Setup

You'll need to add the following "glue code" to your application, ideally as `ReSwiftRxBridge.swift`:

```swift
import ReSwiftRx
import RxSwift

extension Variable: ObservablePropertyType {
    public typealias ValueType = Element
    public typealias DisposeType = Disposable

    public func subscribe(_ function: @escaping (Element) -> Void) -> Disposable? {
        return self.asObservable().subscribe(onNext: function)
    }
}

extension Observable: StreamType {
    public typealias ValueType = Element
    public typealias DisposeType = Disposable

    public func subscribe(_ function: @escaping (Element) -> Void) -> Disposable? {
        return self.subscribe(onNext: function)
    }
}
```

One caveat is that due to RxSwift's `Disposable`s not being extensible, you can't use the `dispatch(_:)` function on `Store` with an `Observable`.

Other than that, you're all set up!
