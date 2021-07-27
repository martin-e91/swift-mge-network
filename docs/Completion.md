# Completion

A completion to handle a result or an error.

``` swift
public typealias Completion<T, E: Error> = (Result<T, E>) -> Void
```
