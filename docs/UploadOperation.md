# UploadOperation

The `CompletionOperation` implementation for executing upload tasks.

``` swift
public final class UploadOperation: CompletionOperation<Data, NetworkError> 
```

## Inheritance

`CompletionOperation<Data, NetworkError>`

## Initializers

### `init(session:uploadRequest:)`

Creates a new `UploadOperation` with the given session.

``` swift
public init(session: URLSession, uploadRequest: UploadRequest) 
```

#### Parameters

  - session: The session instance to be used by this operation.
  - request: The request to be performed.
