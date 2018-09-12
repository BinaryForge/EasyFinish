//
//  ViewController.swift
//  EasyFinish
//
//  Created by Alexey Kuznetsov on 8/15/18.
//  Copyright © 2018 Alexey Kuznetsov. All rights reserved.
//

import UIKit
import CoreData

class TodoListViewController: UITableViewController{
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    var itemArray = [Item]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
     
     Parameters: tableView, IndexPath
     Returns: N/A
     */
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        context.delete(itemArray[indexPath.row])
        itemArray.remove(at: indexPath.row)
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
                 let newItem = Item(context: self.context)
                 newItem.title = textfield.text!
                 newItem.check = false
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
    
    /*
     Load items from persistentContainer
     Parameters: N/A
     Returns: N/A
     */
    func loadItems(){
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        do{
            itemArray = try context.fetch(request)
        }
        catch{
            print("Error")
        }
   }

    /*
     Save user items into persistentContainer
     
     Parameters: N/A
     Returns: N/A
     */
    func saveItems(){
        do{
            try context.save()
        }catch{
            print("Error")
        }
         self.tableView.reloadData()
    }
    
}

