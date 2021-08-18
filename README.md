# MGENetwork

![GitHub tag (latest SemVer)](https://img.shields.io/github/v/tag/martin-e91/MGENetwork)
[![License](https://img.shields.io/github/license/martin-e91/MGENetwork)](LICENSE)

## Description 

A swifty network layer powered by `Operation`s  and `OperationQueues`.


## Example

To run the example project, clone this repo, and open MGENetwork.xcworkspace from the iOS Example directory.


## Requirements
Requires iOS 9.0.


## Installation

Add this to your project using Swift Package Manager. 
In Xcode that is simply: 'File > Swift Packages > Add Package Dependency...', paste the link to this repo and you're done.


## Usage

 The clean way to use this is to use the protocol `NetworkProvider` as a gateway for all the network related tasks.

1.  Add this to your file `import` statements

```swift
import MGENetwork
```



2. Instantiate a `NetworkClient` masking it with the `NetworkProvider` protocol

```swift 
let networkClient: NetworkProvider = NetworkClient()
```



3. Declare a response type conforming to `Decodable`

```swift 
struct MyResponse: Decodable {
  let id: Int
  let message: String
}
```



4. Declare a `Requestable` conforming type, or use the predefined `NetworkRequest` from the module, in order to describe an HTTP Request

```swift 
let request = NetworkRequest<MyResponse>(method: .get, endpoint: "www.domain.com")
```



5. Pass the `request` instance as argument to the `perform` method of the `NetworkProvider` like that: 

```swift 
networkClient.perform(request) { [weak self] result in 
	switch result {
	case .failure(let error):
    		self?.handle(error)
    
	case .success(let data):
    		self?.updateUI(with: data)
  }
}
```



## Documentation

You can find the complete documentation [here](https://martin-e91.github.io/MGENetwork/docs)

## Contributing 

Feel free to give your contribution or open a <a href="https://github.com/martin-e91/MGENetwork/issues/new/choose">new issue</a>! 😄


## Author

Martin Essuman


## License

MGENetwork is available under the MIT license. See [the LICENSE file](LICENSE) for more information.
