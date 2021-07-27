# NetworkError

Error occurring upon network tasks.

``` swift
public enum NetworkError: Error 
```

## Inheritance

`Error`

## Enumeration Cases

### `badRequest`

Occurs when `400` status code is received from the server.

``` swift
case badRequest
```

### `encodingFailure`

An error occuring while performing encoding operations.

``` swift
case encodingFailure
```

### `invalidData`

Error occuring when data is invalid.

``` swift
case invalidData
```

### `invalidParameters`

Error occuring when building a request with invalid parameter.

``` swift
case invalidParameters(parameters: Any)
```

### `invalidURL`

Error occurring when trying to create an invalid `URL` instance.

``` swift
case invalidURL
```

### `forbidden`

Occurs when `403` status code is received from the server.

``` swift
case forbidden
```

### `generic`

A generic error.

``` swift
case generic(Error)
```

### `notFound`

Occurs when `404` status code is received from the server.

``` swift
case notFound
```

### `unauthorized`

Occurs when `401` status code is received from the server.

``` swift
case unauthorized
```

### `unknown`

Used when an unkown error occurs.

``` swift
case unknown
```

## Properties

### `message`

A message for better understanding the error.

``` swift
public var message: String 
```
