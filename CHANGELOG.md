#Upcoming Release

#4.0.1
**API Changes:**

- `dispatch(_ stream:)` now returns a subscription reference.

#3.0.6
**Breaking API Changes:**

- Remove `StateType` - @Qata

#3.0.5
**Breaking API Changes:**

- Change Reducer to a generic function type - @Qata

**API Changes:**

- Rename `Middleware.increase(_:)` to `Middleware.flatMap(_:)` - @Qata
- Make `Middleware.sideEffect(_:)` supply an escaping dispatch function - @Qata

#3.0.4
**API Changes:**

- Change Reducer.transform to be publicly accessible - @Qata
- Change Store.observable to be open with a private setter - @Qata

#3.0.3
**Breaking API Changes:**

- Change all of Store's instance variables to be immutable except `observable`, whose setter is now private - @Qata
- Change all of Store's instance variables to not be implicitly unwrapped optionals because that was gross - @Qata

#3.0.2
**Breaking API Changes:**

- Remove StoreType - @Qata
- Remove stateType: label from Store.init (this was required for StoreType to work) - @Qata
- Change DispatchQueue handling location from Store to ObservableProperty - @Qata

**API Changes:**

- Add the `dispatchQueue:` argument to the initialiser. The queue is a DispatchQueue which is used as the execution context for  - @Qata
- Use default arguments in the main initialiser and remove the convenience initialiser (Swift autogenerates convenience initialisers when default arguments are used) - @Qata
- Add `map(_:)`, `distinct(_:)` and `distinct()` to `ObservableProperty` - @Qata

**Bug Fixes:**

- Remove the exception when dispatching from reducers. This was causing issues with asynchronous dispatching - @Qata

#3.0.1
**API Changes:**

- Add the `increase` method to `Middleware`, allowing you to transform one action into many - @Qata

**Bug Fixes:**

- Move the setting of the store observable's value out of the locked area, preventing updates from triggering the "Reducers dispatching actions" exception - @Qata

#3.0.0
**Breaking API Changes:**

- Remove all subscription as delegation (`StoreSubscriber`) - @Qata
- Remove `ActionCreator` since this can easily be solved with FRP as a single value stream - @Qata
- Simplify `Store` and change it to use observables - @Qata
- Remove the `Reducer` protocol and create a `Reducer` struct that is generic over the `StateType` of your `Store` - @Qata
- Remove the `Middleware` typealias and create a `Middleware` struct that is generic over the `StateType` of your `Store` - @Qata

**API Changes:**

- Add FRP conforming protocols to allow easy plugging-in to FRP libraries. - @Qata
- Add a `dispatch` function to `Store` to allow reactive streams of `Action`s to be lifted into `Store` - @Qata
