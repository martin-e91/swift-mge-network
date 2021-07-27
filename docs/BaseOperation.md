# BaseOperation

A foundation for an operation implementing a KVO-monitored state.

``` swift
open class BaseOperation: Operation 
```

## Inheritance

`Operation`

## Properties

### `isAsynchronous`

``` swift
override open var isAsynchronous: Bool 
```

### `isExecuting`

``` swift
override open var isExecuting: Bool 
```

### `isReady`

``` swift
override open var isReady: Bool 
```

### `isCancelled`

``` swift
override open var isCancelled: Bool 
```

### `isFinished`

``` swift
override open var isFinished: Bool 
```

## Methods

### `start()`

``` swift
override open func start() 
```

### `main()`

``` swift
override open func main() 
```

### `cancel()`

``` swift
override open func cancel() 
```

### `execute()`

``` swift
open func execute() 
```
