//
//  RedditChildrenList.swift
//  RedditAPIProject
//
//  Created by Stanley Ejechi on 8/27/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import Foundation

struct RedditChildrenList: Codable {
  var redditChildrenData: RedditChildrenData
  
  enum CodingKeys: String, CodingKey {
    case redditChildrenData = "data"
  }
}
