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
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    var itemArray = [Item]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadItems()
        
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
        saveItems()
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
                 self.saveItems()
            }
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new item"
            textfield = alertTextfield
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    func loadItems(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                itemArray = try decoder.decode([Item].self, from: data )
            }
            catch{
                print("Error")
            }
        }
    }
    
    /*
     Save user items into plist file
     
     Parameters: N/A
     Returns: N/A
     */
    func saveItems(){
        let encoder = PropertyListEncoder()
        do{
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath!)
        }catch{
            print("Error")
        }
         self.tableView.reloadData()
    }
    
}

