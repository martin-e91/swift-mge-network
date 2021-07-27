# DownloadOperation

The `CompletionOperation` implementation for executing download tasks.

``` swift
public final class DownloadOperation: CompletionOperation<Data, NetworkError> 
```

## Inheritance

`CompletionOperation<Data, NetworkError>`

## Initializers

### `init(session:urlString:)`

Creates a new DownloadOperation that will use the given session for downloading data from the specified url.

``` swift
required public init(session: URLSession, urlString: String) 
```

#### Parameters

  - session: the session instance to be used by this operation.
  - urlString: the url used by this operation.

## Methods

### `execute()`

``` swift
public override func execute() 
```
