//
//  ViewController.swift
//  RedditAPIProject
//
//  Created by Stanley Ejechi on 8/27/19.
//  Copyright © 2019 MobileConsultingSolutions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  @IBOutlet weak var childrenDataTableView: UITableView!
  var redditViewModel = RedditViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUpViewController()
  }
  
  private func setUpViewController() {
    childrenDataTableView.dataSource = self
    childrenDataTableView.delegate = self
    childrenDataTableView.rowHeight = 158
    redditViewModel.setCallbacks(updateCallback: getUpdateCallback(), displayErrorCallback: getDisplayErrorCallback())
    redditViewModel.fetchInitialChildren()
  }
  
  private func getUpdateCallback() -> (() -> Void) {
    return { [weak self] in
      DispatchQueue.main.async {
        self?.childrenDataTableView.reloadData()
      }
    }
  }
  
  private func getDisplayErrorCallback() -> ((String, String) -> Void) {
    return { [weak self] (title, message) in
      let alertController = UIAlertController(title: title,
                                              message: message,
                                              preferredStyle: .alert)
      alertController.addAction(UIAlertAction(title: "Ok",
                                              style: .default))
      self?.present(alertController,
                    animated: true,
                    completion: nil)
    }
  }
}

extension ViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return redditViewModel.getRowCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier = "Cell"
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ChildrenDataTableViewCell else {
      fatalError("The cell is not of type ChildrenDataTableViewCell")
    }
    let displayInfo = redditViewModel.getData(for: indexPath.row)
    cell.setUpCell(with: displayInfo.title, imageURL: displayInfo.imageURLString)    
    return cell
  }
}

extension ViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == redditViewModel.getRowCount() - 5 {
      redditViewModel.getMoreChildren()
    }
  }
}

