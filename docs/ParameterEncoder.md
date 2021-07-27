# ParameterEncoder

Encodes properly parameters for a request.

``` swift
public protocol ParameterEncoder 
```

## Requirements

### encode(urlRequest:​with:​)

Encodes the given parameters adding them to the given `URLRequest` instance.

``` swift
static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
```

#### Parameters

  - urlRequest: the `URLRequest` to which parameters are going to be added.
  - parameters: parameters to add to the request.
