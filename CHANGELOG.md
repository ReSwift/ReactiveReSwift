#Upcoming Release
**Breaking API Changes:**

- Remove all subscription as delegation (`StoreSubscriber`) - @Qata
- Remove `ActionCreator` since this can easily be solved with Rx as a single value stream - @Qata
- Simplify `Store` and change it to use observables - @Qata
- Remove the `Reducer` protocol and create a `Reducer` struct that is generic over the `StateType` of your `Store` - @Qata
- Remove the `Middleware` typealias and create a `Middleware` struct that is generic over the `StateType` of your `Store` - @Qata

**API Changes:**

- Add Rx conforming protocols to allow easy plugging-in to FRP libraries. - @Qata
- Add a `dispatch` function to `Store` to allow reactive streams of `Action`s to be lifted into `Store` - @Qata

#3.0.0
*Released: 11/12/2016*

**Breaking API Changes:**

- Dropped support for Swift 2.2 and lower (#157) - @Ben-G

**API Changes:**

- Mark `Store` as `open`, this reverts a previously accidental breaking API Change (#157) - @Ben-G

**Other**:

- Update to Swift 3.0.1 - @Cristiam, @Ben-G
- Documentation changes - @vkotovv

#2.1.0

*Released: 09/15/2016*

**Other**:

- Swift 3 preview compatibility, maintaining Swift 2 naming - (#126) - @agentk
- Xcode 8 GM Swift 3 Updates (#149) - @tkersey
- Migrate Quick/Nimble testing to XCTest - (#127) - @agentk
- Automatically build docs via Travis CI (#128) - @agentk
- Documentation Updates & Fixes- @mikekavouras, @ColinEberhardt

#2.0.0

*Released: 06/27/2016*

**Breaking API Changes**:

- Significant Improvements to Serialization Code for `StandardAction` (relevant for recording tools) - @okla

**Other**:

- Swift 2.3 Updates - @agentk
- Documentation Updates & Fixes - @okla, @gregpardo, @tomj, @askielboe, @mitsuse, @esttorhe, @RyanCCollins, @thomaspaulmann, @jlampa


#1.0.0

*Released: 03/19/2016*

**API Changes:**
- Remove callback arguments on synchronous dispatch methods - @Ben-G

**Other:**

- Move all documentation source into `Docs`, except `Readme`, `Changelog` and `License` - @agentk
- Replace duplicated documentation with an enhanced `generate_docs.sh` build script - @agentk
- Set CocoaPods documentation URL - (#56) @agentk
- Update documentation for 1.0 release - @Ben-G

#0.2.5

*Released: 02/20/2016*

**API Changes:**

- Subscribers can now sub-select a state when they subscribe to the store (#61) - @Ben-G
- Rename initially dispatched Action to `ReSwiftInit` - @vfn

**Fixes:**

- Fix retain cycle caused by middleware (issue: #66) - @Ben-G
- Store now holds weak references to subscribers to avoid unexpected memory managegement behavior (issue: #62) - @vfn
- Documentation Fixes - @victorpimentel, @vfn, @juggernate, @raheelahmad

**Other:**

- We now have a [hosted documentation for ReSwift](http://reswift.github.io/ReSwift/master/) - @agentk
- Refactored subscribers into a explicit `Subscription` typealias - @DivineDominion
- Refactored `dispatch` for `AsyncActionCreator` to avoid duplicate code - @sendyhalim

#0.2.4

*Released: 01/23/2016*

**API Changes:**

- Pass typed store reference into `ActionCreator`. `ActionCreator` can now access `Store`s state without the need for typecasts - @Ben-G
- `Store` can now be initialized with an empty state, allowing reducers to hydrate the store - @Ben-G

**Bugfixes**

- Break retain cycle when using middelware - @sendyhalim

**Other:**

- Update Documentation to reflect renaming to ReSwift - @agentk
- Documentation fixes - @orta and @sendyhalim
- Refactoring - @dcvz and @sendyhalim
