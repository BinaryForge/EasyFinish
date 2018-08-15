//
//  ViewController.swift
//  EasyFinish
//
//  Created by Alexey Kuznetsov on 8/15/18.
//  Copyright © 2018 Alexey Kuznetsov. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController{
    
    let itemList : [String] = ["Eggs", "Milk", "Steak"]
    
    
    override func viewDidLoad() {
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
    

    
    
}

