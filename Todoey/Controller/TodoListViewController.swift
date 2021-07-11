//
//  ViewController.swift
//  Todoey
//
//  Created by Philipp Muellauer on 02/12/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    let defaults = UserDefaults.standard //An interface to the user’s defaults database, where you store key-value pairs persistently across launches of your app.
    
    var items = ["Buy products", "Complete chalange", "Clean up the appartment"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Перезаписываем сохраненный массив items в исходный
        if let itemList = defaults.object(forKey: "TodoList") as? [String] {
            items = itemList
        }
    }


//MARK: - TableView DataSource Methods

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) ?
           (tableView.cellForRow(at: indexPath)?.accessoryType = .none) :
           (tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark)
        
        tableView.deselectRow(at: indexPath, animated: true) //Анимация затемнения
    }
    
    //MARK: - Add New Items Section
    
    @IBAction func addItemPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { action in
            //what will happen when the user press "Add Item"
            
            self.items.append(textField.text!)
            
            self.defaults.set(self.items, forKey: "TodoList") //сохраняем массив items

            self.tableView.reloadData() //обновляем items
        }
        
        alert.addTextField { alertText in
            alertText.placeholder = "Create new item"
            textField = alertText
        }
        
        alert.addAction(action) //здесь происходит действие, которое мы прописали в action
        
        self.present(alert, animated: true, completion: nil) //чтобы был показан UIAlertController при нажатии на "+"
    }
}



