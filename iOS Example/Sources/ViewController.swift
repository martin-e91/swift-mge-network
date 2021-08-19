//
//  iOS Example
//

import Combine
import UIKit
import MGENetwork
import MGELogger

class ViewController: UIViewController {
  private struct LoggingConfiguration: LoggerConfiguration {
    var minimumLogLevel: Logger.Log.Level = .debug
    var destination: Logger.Log.Destination = .console
    let maxMessagesLength: UInt = 10000
    let timestampFormatter: DateFormatter = {
      let formatter = DateFormatter()
      formatter.dateFormat = "dd-MM-yyyy"
      return formatter
    }()
    let truncatingToken: String = ""
  }
  private struct NetworkConfiguration: NetworkClientConfiguration {
    let loggerConfiguration: LoggerConfiguration = LoggingConfiguration()
    
    let session: URLSession = URLSession(configuration: .default)
  }
  
  private let networkClient: NetworkProvider = NetworkClient(with: NetworkConfiguration())
  
  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var textLabel: UILabel!
  
  @IBOutlet weak var button: UIButton!
  
  private let hudView = UIView()
  
  private let activityIndicator = UIActivityIndicatorView(style: .large)
  
  private var subscriptions = Set<AnyCancellable>()
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    setup()
    fetchData()
  }
  
  private func setup() {
    navigationItem.title = "Chuck Norris Facts"
    
    view.addSubview(activityIndicator)
    activityIndicator.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
    ])
    activityIndicator.hidesWhenStopped = true
    
    textLabel.text = nil
    textLabel.numberOfLines = 0
    textLabel.textAlignment = .center
    
    setupButton()
    setupHud()
  }
  
  private func setupButton() {
    button.setTitle("Another one!", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 10
  }
  
  private func setupHud() {
    hudView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    hudView.isHidden = true
    view.addSubview(hudView)
    
    hudView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      hudView.topAnchor.constraint(equalTo: view.topAnchor),
      hudView.rightAnchor.constraint(equalTo: view.rightAnchor),
      hudView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
      hudView.leftAnchor.constraint(equalTo: view.leftAnchor)
    ])
  }
  
  @objc
  func fetchData() {
    showHud()
    
    networkClient.perform(Requests.randomFact.make())
      .sink { [weak self] completion in
        self?.hideHud()
      } receiveValue: { [weak self] fact in
        self?.hideHud()
        self?.handle(fact: fact)
      }
      .store(in: &subscriptions)
    return
    
    
    //    networkClient.perform(Requests.randomFact.make()) { [weak self] result in
    //      defer {
    //        self?.hideHud()
    //      }
    //
    //      guard let self = self else {
    //        return
    //      }
    //
    //      switch result {
    //      case .failure(let error):
    //        self.showDialog(with: error)
    //
    //      case .success(let fact):
    //        self.handle(fact: fact)
    //      }
    //    }
  }
  
  private func downloadImage(from urlString: String, completion: @escaping (Data?) -> Void) {
    networkClient.download(from: urlString)
      .sink { _ in
      } receiveValue: { data in
        completion(data)
      }
      .store(in: &subscriptions)
  }
  
  private func showDialog(with error: NetworkError) {
    let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  private func handle(fact: ChuckNorrisFact) {
    textLabel.text = fact.text.capitalized
    downloadImage(from: fact.iconUrl) { [weak self] imageData in
      guard let self = self, let imageData = imageData
      else {
        return
      }
      
      self.imageView.image = UIImage(data: imageData)
      self.view.setNeedsLayout()
    }
  }
  
  private func showHud() {
    activityIndicator.startAnimating()
    hudView.isHidden = false
  }
  
  private func hideHud() {
    activityIndicator.stopAnimating()
    hudView.isHidden = true
  }
}

