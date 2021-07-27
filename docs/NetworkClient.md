# NetworkClient

A client for making network calls.

``` swift
public final class NetworkClient: NetworkProvider 
```

## Inheritance

[`NetworkProvider`](/NetworkProvider)

## Initializers

### `init(with:)`

Instanciates the client with the given session.

``` swift
public init(with session: URLSession = URLSession(configuration: .default)) 
```

#### Parameters

  - session: The session that will be used by this client. When not specified, it will  use a default configured session.

## Methods

### `perform(_:completion:)`

``` swift
@discardableResult
  public func perform<R, T>(_ request: R, completion: @escaping Completion<T, NetworkError>) -> Operation where R : Requestable, T == R.ResponseType 
```

### `download(from:completion:)`

``` swift
@discardableResult
  public func download(from urlString: String, completion: @escaping Completion<Data, NetworkError>) -> Operation 
```
