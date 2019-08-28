//
//  RedditViewModel.swift
//  RedditAPIProject
//
//  Created by Stanley Ejechi on 8/27/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class RedditViewModel: NSObject {
  private let baseURLString = "http://www.reddit.com/.json"
  private var nextPageParamaterValue = ""
  private var dataArray: [RedditChildrenList] = []
  private var updateCallback: () -> Void = {}
  private var displayErrorCallback: (_ title: String, _ message: String) -> Void = {(title, message) in }
  private var nextPageURLString: String {
    if nextPageParamaterValue.isEmpty {
      return baseURLString
    } else {
      return baseURLString + "?after=" + nextPageParamaterValue
    }
  }
  
  func fetchInitialChildren() {
    NetworkManager().getData(from: baseURLString) { [weak self] (data, error) in
      if let error = error {
        self?.displayErrorCallback("Network Error!", "We encountered the following error with the network: \(error.localizedDescription)")
      }
      guard let data = data, let response = try? JSONDecoder().decode(RedditDataModel.self, from: data) else {
        self?.displayErrorCallback("Oops!", "Something went wrong. Looks like the network request worked, but the data was not present. 😕")
        return
      }
      self?.nextPageParamaterValue = response.redditDataList.nextPageParamaterValue
      self?.dataArray = response.redditDataList.redditChildrenList
      self?.updateCallback()
    }
  }
  
  func getRowCount() -> Int {
    return dataArray.count
  }
  
  func getData(for indexPath: Int) -> (title: String, imageURLString: String) {
    let displayItem = dataArray[indexPath]
    return (displayItem.redditChildrenData.title, displayItem.redditChildrenData.thumbnail)
  }
  
  func getMoreChildren() {
    NetworkManager().getData(from: nextPageURLString) { [weak self] (data, error) in
      if let error = error {
        self?.displayErrorCallback("Oops!", "There was an error with the network call! \nError: \(error.localizedDescription)")
      }
      guard let data = data, let response = try? JSONDecoder().decode(RedditDataModel.self, from: data) else {
        self?.displayErrorCallback("Oops!", "Something went wrong. Looks like the network request worked, but the data was not present. 😕")
        return
      }
      self?.nextPageParamaterValue = response.redditDataList.nextPageParamaterValue
      self?.dataArray.append(contentsOf: response.redditDataList.redditChildrenList) 
      self?.updateCallback()
    }
  }
  
  func setCallbacks(updateCallback: @escaping () -> Void, displayErrorCallback: @escaping (String, String) -> Void) {
    self.updateCallback = updateCallback
    self.displayErrorCallback = displayErrorCallback
  }
}
