//
//  Navigation2Controller.swift
//  testNavigation
//
//  Created by Thanawat Suchato on 9/8/2562 BE.
//  Copyright © 2562 Thanawat.Suchato. All rights reserved.
//

import UIKit

class Navigation2Controller: UIViewController {
  
  @IBOutlet weak var todoTextField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  private static let showDetailIdentifier = "ShowDetailFromNavigation2Id"
  
  var todoList: [TodoItem] = []
  
  // MARK: - Even handler
  @IBAction func didTapAddTodoItemButton(_ sender: Any) {
    guard let todoText = todoTextField.text,
      !todoText.isEmpty else {
        return
    }
    
    let newItem: TodoItem = TodoItem(title: todoText, isChecked: false, description: nil)
    todoList.append(newItem)
    todoTextField.text = nil
    tableView.reloadData()
  }
  
  @IBAction func didTapCloseButton(_ sender: Any) {
    self.dismiss(animated: true, completion: nil)
  }
  
  // MARK: - UIStoryboardSegue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == Navigation2Controller.showDetailIdentifier,
      let destinationView = segue.destination as? DetailViewController {
      guard let index = sender as? Int, todoList.indices.contains(index) else { return }
      
      destinationView.delegate = self
      destinationView.setItem(newItem: todoList[index], index: index)
    }
  }
}

extension Navigation2Controller: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todoList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard todoList.indices.contains(indexPath.row),
      let cell = tableView.dequeueReusableCell(withIdentifier: "TodoListCell", for: indexPath) as? TodoItemTableViewCell else {
        return UITableViewCell()
    }
    
    cell.setupUI(todoItem: todoList[indexPath.row])
    cell.delegate = self
    
    return cell
  }
}

extension Navigation2Controller: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    self.performSegue(withIdentifier: Navigation2Controller.showDetailIdentifier, sender: indexPath.item)
  }
}

extension Navigation2Controller: TodoItemTableViewCellDelegate {
  func didCheckTodoItem(cell: TodoItemTableViewCell) {
    if let index = tableView.indexPath(for: cell) {
      let todoItem = todoList.remove(at: index.row)
      let newTodoItem = TodoItem(title: todoItem.title, isChecked: !todoItem.isChecked, description: todoItem.description)
      todoList.insert(newTodoItem, at: index.row)
      tableView.reloadData()
    }
  }
}

extension Navigation2Controller: DetailViewDelegate {
  func updateDescription(_ string: String, index: Int) {
    guard todoList.indices.contains(index) else { return }
    todoList[index].description = string
    tableView.reloadData()
  }
}

