//
//  TodoListTableViewCell.swift
//  testNavigation
//
//  Created by Thanawat Suchato on 8/8/2562 BE.
//  Copyright © 2562 Thanawat.Suchato. All rights reserved.
//

import UIKit

protocol TodoItemTableViewCellDelegate: class {
  func didCheckTodoItem(cell: TodoItemTableViewCell)
}

class TodoItemTableViewCell: UITableViewCell {
  
  @IBOutlet weak var checkButton: UIButton!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var detailLabel: UILabel!
  
  weak var delegate: TodoItemTableViewCellDelegate?
  
  func setupUI(todoItem: TodoItem) {
    titleLabel.text = todoItem.title
    detailLabel.text = todoItem.description
    
    if todoItem.isChecked {
      checkButton.setImage(#imageLiteral(resourceName: "check_icon"), for: .normal)
    } else {
      checkButton.setImage(#imageLiteral(resourceName: "uncheck_icon"), for: .normal)
    }
  }
  
  @IBAction func didTapCheckButton(_ sender: Any) {
    delegate?.didCheckTodoItem(cell: self)
  }
}

