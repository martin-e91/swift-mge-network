# NetworkProvider

An entity providing ways of making requests against the network.

``` swift
public protocol NetworkProvider 
```

## Default Implementations

### `isLoggingEnabled`

``` swift
var isLoggingEnabled: Bool 
```

## Requirements

### isLoggingEnabled

Whether the logging is enabled or not. Default value is `true`.

``` swift
var isLoggingEnabled: Bool 
```

### perform(\_:​completion:​)

Performs a request against the network.

``` swift
@discardableResult
  func perform<R, T>(_ request: R, completion: @escaping Completion<T, NetworkError>) -> Operation where R: Requestable, R.ResponseType == T
```

#### Parameters

  - request: The request to process.
  - completion: Completion block for handling result.

### download(from:​completion:​)

Downloads raw data from the given url.

``` swift
@discardableResult
  func download(from urlString: String, completion: @escaping Completion<Data, NetworkError>) -> Operation
```

#### Parameters

  - urlString: The endpoint for the network task.
  - completion: Completion block for handling result.
