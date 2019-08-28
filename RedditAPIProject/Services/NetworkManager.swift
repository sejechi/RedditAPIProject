//
//  NetworkManager.swift
//  RedditAPIProject
//
//  Created by Stanley Ejechi on 8/27/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import Foundation

class NetworkManager {
  
  func getData(from urlString: String, _ completionHandler: @escaping (Data?, Error?) -> Void) {
    guard let url = URL(string: urlString) else { completionHandler(nil, nil); return }
    URLSession.shared.dataTask(with: url) { (data, _, error) in
      completionHandler(data, error)
    }.resume()
  }
}


