//
//  RedditDataModel.swift
//  RedditAPIProject
//
//  Created by Stanley Ejechi on 8/27/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import Foundation

struct RedditDataModel: Codable {
  var redditDataList: RedditDataList
  
  enum CodingKeys: String, CodingKey {
    case redditDataList = "data"
  }
}
