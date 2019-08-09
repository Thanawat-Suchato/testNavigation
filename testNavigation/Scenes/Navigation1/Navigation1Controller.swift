//
//  Navigation1Controller.swift
//  testNavigation
//
//  Created by Thanawat Suchato on 9/8/2562 BE.
//  Copyright © 2562 Thanawat.Suchato. All rights reserved.
//

import UIKit

class Navigation1Controller: UIViewController {
  
  @IBOutlet weak var todoTextField: UITextField!
  @IBOutlet weak var tableView: UITableView!
  
  var todoList: [TodoItem] = []
  
  // MARK: - Methods
  func navigateToDetail(item: TodoItem, index: Int) {
    let storyboard = UIStoryboard(name: "Detail", bundle: nil)
    guard let detailViewController = storyboard.instantiateViewController(withIdentifier: "DetailViewControllerId") as? DetailViewController else { return }
    
    detailViewController.delegate = self
    detailViewController.setItem(newItem: item, index: index)
    self.navigationController?.pushViewController(detailViewController, animated: true)
  }
  
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
}

extension Navigation1Controller: UITableViewDataSource {
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

extension Navigation1Controller: UITableViewDelegate {
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    guard todoList.indices.contains(indexPath.row) else { return }
    navigateToDetail(item: todoList[indexPath.row], index: indexPath.row)
  }
}

extension Navigation1Controller: TodoItemTableViewCellDelegate {
  func didCheckTodoItem(cell: TodoItemTableViewCell) {
    if let index = tableView.indexPath(for: cell) {
      let todoItem = todoList.remove(at: index.row)
      let newTodoItem = TodoItem(title: todoItem.title, isChecked: !todoItem.isChecked, description: todoItem.description)
      todoList.insert(newTodoItem, at: index.row)
      tableView.reloadData()
    }
  }
}

extension Navigation1Controller: DetailViewDelegate {
  func updateDescription(_ string: String, index: Int) {
    guard todoList.indices.contains(index) else { return }
    todoList[index].description = string
    tableView.reloadData()
  }
}
