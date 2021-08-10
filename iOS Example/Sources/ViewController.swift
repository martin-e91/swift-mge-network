//
//  ViewController.swift
//  iOS Example
//
//  Created by Martin Essuman on Apr 28, 2020.
//  Copyright © 2020 Martin Godswill Essuman. All rights reserved.
//

import Combine
import UIKit
import MGENetwork
import MGELogger

class ViewController: UIViewController {
  private let networkClient: NetworkProvider = NetworkClient()

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
        print(completion)
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
    self.networkClient.download(from: urlString) { [weak self] result in
      guard let self = self else {
        return
      }
      
      switch result {
      case .failure(let error):
        self.showDialog(with: error)
        completion(nil)
        
      case .success(let data):
        completion(data)
      }
    }
  }
  
  private func showDialog(with error: NetworkError) {
    let alert = UIAlertController(title: "Error", message: error.message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  private func handle(fact: ChuckNorrisFact) {
    self.textLabel.text = fact.text.capitalized
    self.downloadImage(from: fact.iconUrl) { [weak self] imageData in
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

