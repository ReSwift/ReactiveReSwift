# PromiseKit

# Setup

You'll need to add the following "glue code" to your application, ideally as `ReactiveReSwiftBridge.swift`:

```swift
extension Promise: StreamType {
    public typealias ValueType = T
    public typealias DisposableType = DisposableFake

    public func subscribe(_ function: @escaping (T) -> Void) -> DisposableFake? {
        _ = self.then(execute: function)
        return nil
    }
}

public struct DisposableFake: SubscriptionReferenceType {
    public func dispose() {}
}
```

Since PromiseKit doesn't have a property type (since it's not that kind of library), you'll need to use the inbuilt `ObservableProperty` type when making your app's `Store`.

You're all set up!
