# Endpoint

An endpoint provider.

``` swift
public protocol Endpoint 
```

## Default Implementations

### `path`

``` swift
var path: Path 
```

### `completeURLString`

The complete URL string of this endpoint.

``` swift
var completeURLString: String 
```

## Requirements

### baseURL

The base URL string.

``` swift
var baseURL: String 
```

> 

### path

The path parameters of this `Endpoint` instance.

``` swift
var path: Path  
```

### asURL()

Tries to generate an `URL` instance for this endpoint.
Can throw an error while building the `URL` instance.

``` swift
func asURL() throws -> URL
```
