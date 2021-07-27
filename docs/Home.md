# Types

  - [BaseOperation](/BaseOperation):
    A foundation for an operation implementing a KVO-monitored state.
  - [CompletionOperation](/CompletionOperation):
    The `BaseOperation` implementation for executing a completion with a `Result` right before transitioning to `isFinished` state.
  - [DataTaskOperation](/DataTaskOperation):
    An operation for network calls, using data tasks generated from the given session.
    Performs a `NetworkRequest` a completion upon its task termination.
  - [DownloadOperation](/DownloadOperation):
    The `CompletionOperation` implementation for executing download tasks.
  - [UploadOperation](/UploadOperation):
    The `CompletionOperation` implementation for executing upload tasks.
  - [NetworkClient](/NetworkClient):
    A client for making network calls.
  - [HTTPMethod](/HTTPMethod):
    The set of HTTP methods for an HTTP request.
  - [JSONParameterEncoder](/JSONParameterEncoder):
    The `ParameterEncoder` for performing the encoding of parameters as `JSON` body for a `URLRequest`.
  - [NetworkError](/NetworkError):
    Error occurring upon network tasks.
  - [URLParametersEncoder](/URLParametersEncoder):
    The `ParameterEncoder` for performing the encoding of query parameters for a `URLRequest`.
  - [BaseOperation.State](/BaseOperation_State)
  - [NetworkRequest](/NetworkRequest):
    Models a network request generic over the response type.

# Protocols

  - [Endpoint](/Endpoint):
    An endpoint provider.
  - [NetworkProvider](/NetworkProvider):
    An entity providing ways of making requests against the network.
  - [ParameterEncoder](/ParameterEncoder):
    Encodes properly parameters for a request.
  - [Requestable](/Requestable):
    An entity that can be used to describe an HTTP request.

# Global Typealiases

  - [Completion](/Completion):
    A completion to handle a result or an error.
  - [Parameters](/Parameters):
    Parameters for a `NetworkRequest`.
  - [Path](/Path):
    Represents the path of an URL string.
  - [HTTPHeaders](/HTTPHeaders):
    A type for representing HTTP header fields.

# Extensions

  - [Encodable](/Encodable)
  - [String](/String)
