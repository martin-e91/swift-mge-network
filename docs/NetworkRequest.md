# NetworkRequest

Models a network request generic over the response type.

``` swift
public struct NetworkRequest<Response>: Requestable where Response: Decodable 
```

## Inheritance

[`Requestable`](/Requestable)

## Nested Type Aliases

### `ResponseType`

``` swift
public typealias ResponseType = Response
```

## Initializers

### `init(method:endpoint:defaultHeaders:additionalHeaders:parameters:)`

``` swift
public init(
    method: HTTPMethod,
    endpoint: Endpoint,
    defaultHeaders: HTTPHeaders = ["Accept": "application/json", "Content-Type": "application/json"],
    additionalHeaders: HTTPHeaders = [:],
    parameters: Parameters = [:]
  ) 
```

### `init(urlString:)`

Creates a simple get request for the given urlString.

``` swift
public init(urlString: String) 
```

#### Parameters

  - urlString: The url string for this request.

## Properties

### `endpoint`

``` swift
public let endpoint: Endpoint
```

### `method`

``` swift
public let method: HTTPMethod
```

### `headers`

``` swift
public let headers: HTTPHeaders
```

### `parameters`

``` swift
public let parameters: Parameters
```

## Methods

### `asURLRequest()`

``` swift
public func asURLRequest() throws -> URLRequest 
```
