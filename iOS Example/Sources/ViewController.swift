//
//  ViewController.swift
//  iOS Example
//
//  Created by Martin Essuman on Apr 28, 2020.
//  Copyright © 2020 Martin Godswill Essuman. All rights reserved.
//

import UIKit
import MGENetwork

class ViewController: UIViewController {
  private let networkClient: NetworkProvider = NetworkClient()

  @IBOutlet weak var imageView: UIImageView!
  
  @IBOutlet weak var textLabel: UILabel!
  
  @IBOutlet weak var button: UIButton!

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    setup()
    fetchData()
  }
  
  private func setup() {
    navigationItem.title = "Chuck Norris Facts"
    
    textLabel.text = nil
    textLabel.numberOfLines = 0
    
    button.setTitle("Another one!", for: .normal)
    button.setTitleColor(.white, for: .normal)
    button.addTarget(self, action: #selector(fetchData), for: .touchUpInside)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 16
  }
  
  @objc
  func fetchData() {
    networkClient.perform(Requests.randomFact.make()) { [weak self] (result: Result<ChuckNorrisFact, NetworkError>) in
      guard let self = self else {
        return
      }
      
      switch result {
      case .failure(let error):
        self.showDialog(with: error)
        
      case .success(let data):
        self.textLabel.text = data.text.capitalized
        self.downloadImage(from: data.iconUrl) { imageData in
          self.imageView.image = UIImage(data: imageData)
          self.view.setNeedsLayout()
        }
      }
    }
  }
  
  private func downloadImage(from urlString: String, completion: @escaping (Data) -> Void) {
    self.networkClient.download(from: urlString) { result in
      switch result {
      case .failure(let error):
        self.showDialog(with: error)
        
      case .success(let data):
        completion(data)
      }
    }
  }
  
  private func showDialog(with error: Error) {
    let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
}

