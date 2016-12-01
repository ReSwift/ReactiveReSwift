# ReactiveSwift + ReactiveCocoa

# Setup

You'll need to add the following "glue code" to your application, ideally as `ReSwiftRxBridge.swift`:

```swift
import ReSwiftRx
import ReactiveSwift

extension MutableProperty: ObservablePropertyType {
    public typealias ValueType = Value

    @discardableResult
    public func subscribe(_ function: @escaping (Value) -> Void) -> SubscriptionReferenceType? {
        let disposable = self.producer.on(value: function).start()
        return AnyDisposable(disposable)
    }
}

extension Signal: StreamType {
    public typealias ValueType = Value

    @discardableResult
    public func subscribe(_ function: @escaping (Value) -> Void) -> SubscriptionReferenceType? {
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

    @discardableResult
    public func subscribe(_ function: @escaping (Value) -> Void) -> SubscriptionReferenceType? {
        return AnyDisposable(self.on(value: function).start())
    }
}

extension AnyDisposable: SubscriptionReferenceType {}
```

This code conforms ReactiveSwift's types to the protocols used in ReSwiftRx.

To create a `mainStore` with ReactiveSwift you'll need to use a MutableProperty as observable.

Here's an example:
```swift
let mainStore = ObservableStore(
    reducer: AppReducer(),
    stateType: AppState.self,
    observable: MutableProperty(AppState(counter: 0))
)
```

That's it, you're all set up.

# Usage

You can now use the `observable` property of `mainStore` as you would any other ReactiveSwift `MutableProperty`.
Here's an example from the RxCounterExample project:

```swift
class ViewController: UIViewController {
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var decreaseButton: UIButton!
    @IBOutlet weak var increaseButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        counterLabel.reactive.text <~ store.observable.producer.map { String($0.counter) }
        let increaseSignal = increaseButton.reactive.trigger(for: UIControlEvents.touchUpInside).map { AppAction.Increase }
        let decreaseSignal = decreaseButton.reactive.trigger(for: UIControlEvents.touchUpInside).map { AppAction.Decrease }
        let counterSignal = SignalProducer(values: [increaseSignal, decreaseSignal]).flatten(.merge)
        store.dispatch(counterSignal)
    }
}
```
