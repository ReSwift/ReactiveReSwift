#Upcoming Release

#3.0.0
**Breaking API Changes:**

- Remove all subscription as delegation (`StoreSubscriber`) - @Qata
- Remove `ActionCreator` since this can easily be solved with Rx as a single value stream - @Qata
- Simplify `Store` and change it to use observables - @Qata
- Remove the `Reducer` protocol and create a `Reducer` struct that is generic over the `StateType` of your `Store` - @Qata
- Remove the `Middleware` typealias and create a `Middleware` struct that is generic over the `StateType` of your `Store` - @Qata

**API Changes:**

- Add Rx conforming protocols to allow easy plugging-in to FRP libraries. - @Qata
- Add a `dispatch` function to `Store` to allow reactive streams of `Action`s to be lifted into `Store` - @Qata
