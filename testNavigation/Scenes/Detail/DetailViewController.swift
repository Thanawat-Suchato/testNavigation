//
//  DetailViewController.swift
//  testNavigation
//
//  Created by Thanawat Suchato on 9/8/2562 BE.
//  Copyright © 2562 Thanawat.Suchato. All rights reserved.
//

import UIKit

protocol DetailViewDelegate: class {
  func updateDescription(_ string: String, index: Int)
}

class DetailViewController: UIViewController {
  
  @IBOutlet weak private var titleLable: UILabel!
  @IBOutlet weak private var descriptionTextField: UITextField!
  
  weak var delegate: DetailViewDelegate?
  
  private var item: TodoItem? = nil
  private var selectedIndex: Int? = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
  }
  
  @IBAction func didTapBackButton(_ sender: Any) {
    if let navigationController = self.navigationController {
      navigationController.popViewController(animated: true)
    } else {
      self.dismiss(animated: true, completion: nil)
    }
  }
  
  @IBAction func didTapUpdateButton(_ sender: Any) {
    guard let index = selectedIndex else { return }
    
    let description = descriptionTextField.text ?? ""
    delegate?.updateDescription((description), index: index)
  }
  
  private func setUI() {
    if let item = item {
      titleLable.text = item.title
      descriptionTextField.text = item.description
    } else {
      titleLable.text = nil
      descriptionTextField.text = nil
    }
  }
  
  func setItem(newItem: TodoItem, index: Int) {
    item = newItem
    selectedIndex = index
  }
}

