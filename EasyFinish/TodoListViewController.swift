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
    var itemList : [String] = ["Eggs", "Milk", "Steak"]

    override func viewDidLoad() {
        if let items = defaults.array(forKey: "TodoList") as? [String]{
            itemList = items
        }
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath)
        cell.textLabel?.text = itemList[indexPath.row]
        return cell
    }
    
    /*
     Set cell rows based on itemList Array
     
     Parameters: tableView, numberOfRowsInSection
     Returns: number of cell rows for UI
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return itemList.count
    }
    
    /*
     Set cell rows based on itemList Array
     
     Parameters: tableView, numberOfRowsInSection
     Returns: number of cell rows for UI
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark{
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
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
            if textfield.text!.isEmpty == false{
                 self.itemList.append(textfield.text!)
                 self.defaults.set(self.itemList, forKey: "TodoList")
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

