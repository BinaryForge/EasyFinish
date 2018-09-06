//
//  ViewController.swift
//  EasyFinish
//
//  Created by Alexey Kuznetsov on 8/15/18.
//  Copyright © 2018 Alexey Kuznetsov. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    let defaults = UserDefaults.standard
    var itemArray = [Item]()
    //var itemList: [String] = ["32","33"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let item_1 = Item()
        item_1.title = "Apple"
        
        let item_2 = Item()
        item_2.title = "Pear"
        
        let item_3 = Item()
        item_2.title = "Grapes"
        
        itemArray.append(item_1)
        itemArray.append(item_2)
        itemArray.append(item_3)
        itemArray.append(item_2)
        itemArray.append(item_3)
        itemArray.append(item_2)
        itemArray.append(item_3)
        itemArray.append(item_2)
        itemArray.append(item_3)
        
        if let items = defaults.array(forKey: "Todo") as? [Item]{
            itemArray = items
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = itemArray[indexPath.row].title
        
        if item.check == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    /*
     Set cell rows based on itemList Array
     
     Parameters: tableView, numberOfRowsInSection
     Returns: number of cell rows for UI
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return itemArray.count
    }
    
    /*
     Set cell rows based on itemList Array
     
     Parameters: tableView, numberOfRowsInSection
     Returns: number of cell rows for UI
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        itemArray[indexPath.row].check = !itemArray[indexPath.row].check
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    /*
     Append new item to TableView
     
     Parameters: N/A
     Returns: N/A
     */
    @IBAction func addToList(_ sender: UIBarButtonItem) {
        var textfield = UITextField()
        let alert = UIAlertController(title: "Add to the list", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            if textfield.text!.isEmpty == false {
                let newItem = Item()
                 newItem.title = textfield.text!
                
                 self.itemArray.append(newItem)
                
                 self.defaults.set(self.itemArray, forKey: "TodoList")
                
                 self.tableView.reloadData()
            }
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new item"
            textfield = alertTextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}

