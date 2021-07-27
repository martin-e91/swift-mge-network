# DataTaskOperation

An operation for network calls, using data tasks generated from the given session.
Performs a `NetworkRequest` a completion upon its task termination.

``` swift
public final class DataTaskOperation<RequestType, DataType>: CompletionOperation<DataType, NetworkError>
where RequestType: Requestable, RequestType.ResponseType == DataType 
```

## Inheritance

`CompletionOperation<DataType, NetworkError>`

## Initializers

### `init(session:request:)`

Creates a new DataTaskOperation that will use the given session for performing the given request.

``` swift
required public init(session: URLSession, request: RequestType) 
```

#### Parameters

  - session: the session instance to be used by this operation.
  - request: the request to be performed.

## Methods

### `execute()`

``` swift
public override func execute() 
```
