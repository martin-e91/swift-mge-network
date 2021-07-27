# Requestable

An entity that can be used to describe an HTTP request.

``` swift
public protocol Requestable: CustomStringConvertible 
```

## Inheritance

`CustomStringConvertible`

## Default Implementations

### `defaultHeaders`

Default headers to include in a request.

``` swift
var defaultHeaders: HTTPHeaders? 
```

### `parameters`

``` swift
var parameters: Parameters 
```

### `description`

``` swift
var description: String 
```

## Requirements

### ResponseType

Type of the response associated with this `Requestable`.

``` swift
associatedtype ResponseType: Decodable
```

### endpoint

The endpoint of this request.

``` swift
var endpoint: Endpoint 
```

### method

HTTP method of this request.

``` swift
var method: HTTPMethod 
```

### headers

HTTP header of this request.

``` swift
var headers: HTTPHeaders 
```

### parameters

Parameters for the request, if any.

``` swift
var parameters: Parameters 
```

> 

### asURLRequest()

Converts this request to an `URLRequest`.

``` swift
func asURLRequest() throws -> URLRequest
```

#### Throws

An error while building the `URL` object.

#### Returns

The `URLRequest` associated with this network request.
