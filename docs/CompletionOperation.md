# CompletionOperation

The `BaseOperation` implementation for executing a completion with a `Result` right before transitioning to `isFinished` state.

``` swift
open class CompletionOperation<T, E>: BaseOperation where E: Error 
```

## Inheritance

[`BaseOperation`](/BaseOperation)

## Properties

### `completion`

``` swift
public var completion: Completion<T, E>?
```

## Methods

### `finish(with:)`

``` swift
public func finish(with success: T) 
```

### `finish(with:)`

``` swift
public func finish(with error: E) 
```
