//
//  RedditDataList.swift
//  RedditAPIProject
//
//  Created by Stanley Ejechi on 8/27/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import Foundation

struct RedditDataList: Codable {
  var redditChildrenList: [RedditChildrenList]
  var nextPageParamaterValue: String
  
  enum CodingKeys: String, CodingKey {
    case redditChildrenList = "children"
    case nextPageParamaterValue = "after"
  }
}
