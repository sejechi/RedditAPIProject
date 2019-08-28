//
//  ChildrenDataTableViewCell.swift
//  RedditAPIProject
//
//  Created by Stanley Ejechi on 8/27/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class ChildrenDataTableViewCell: UITableViewCell {
  @IBOutlet weak var childrenImageView: UIImageView!
  @IBOutlet weak var childrenLabel: UILabel!
  private var updateImage: ((UIImage?) -> Void)?
  
  override func prepareForReuse() {
    updateImage = nil
    childrenImageView.image = nil
  }
  func setUpCell(with title: String, imageURL: String) {
    self.childrenLabel.text = title
    childrenLabel.lineBreakMode = .byWordWrapping
    childrenLabel.numberOfLines = 0
    guard !imageURL.isEmpty else { return }
    let updateCallback: (UIImage?) -> Void = { [weak self] (image) in
      DispatchQueue.main.async {
        self?.childrenImageView.image = image
      }
    }
    self.updateImage = updateCallback
    NetworkManager().getData(from: imageURL) { [weak self] (data, error) in
      guard let data = data else { return }
      if let update = self?.updateImage{
        update(UIImage(data: data))
      }
    }
  }
}
