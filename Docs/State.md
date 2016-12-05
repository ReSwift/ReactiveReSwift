The application state is defined in a single data structure which should be a `struct`. This `struct` can have other `struct`s as members, that allows you to add different sub-states as your app grows.

The state `struct` should store your entire application state, that includes the UI state, the navigation state and the state of your model layer.

Here's an example of a state `struct` as defined in the [Reactive Counter Example](https://github.com/Qata/ReactiveCounterExample):

```swift
struct AppState: StateType {
    var counter: Int = 0
}
```

Your app state `struct` needs to conform to the `StateType` protocol.
