//
//  ImageCache.swift
//  RedditAPIProject
//
//  Created by Stanley Ejechi on 8/28/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class ImageCache {
  private let cache = NSCache<NSString, UIImage>()
  static let shared = ImageCache()
  
  private init() {}
  
  func getImage(with urlStringIdentifier: String) -> UIImage? {
    return cache.object(forKey: urlStringIdentifier as NSString)
  }
  
  func saveToCache(image: UIImage, with urlIdentifierString: String) {
    cache.setObject(image, forKey: urlIdentifierString as NSString)
  }
}

