#Upcoming Release
**API Changes:**

- Add the `dispatchQueue:` argument to the initialiser. The queue is a DispatchQueue which is used as the execution context for  - @Qata
- Use default arguments in the main initialiser and remove the convenience initialiser (Swift autogenerates convenience initialisers when default arguments are used) - @Qata

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
