# Extensions on Encodable

## Methods

### `asDictionary()`

Try to create a dictionary instance from this `Encodable` object.

``` swift
func asDictionary() throws -> [String: Any] 
```

#### Throws

`NetworkError.encodingFailure`

#### Returns

a dictionary instance from this `Encodable` object.
