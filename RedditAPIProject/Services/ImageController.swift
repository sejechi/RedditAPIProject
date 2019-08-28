//
//  ImageController.swift
//  RedditAPIProject
//
//  Created by Stanley Ejechi on 8/28/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class ImageController {
  
  func getImage(with urlIdentifierString: String, _ completionHandler: @escaping (UIImage) -> Void) {
    if let image = ImageCache.shared.getImage(with: urlIdentifierString) {
      completionHandler(image)
    } else {
      // get image from network
      // save image to cache
      // completionHandler with image
    }
  }
}
