//
//  ViewController.swift
//  todoly
//
//  Created by Eugene Choe on 1/24/18.
//  Copyright © 2018 heug. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "CircleCI todoly"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(ViewController.didTapAddItemButton(_:)))
        
//        // Setup a notification to let us know when the app is about to close,
//        // and that we should store the user items to persistence. This will call the
//        // applicationDidEnterBackground() function in this class
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(UIApplicationDelegate.applicationDidEnterBackground(_:)),
//            name: NSNotification.Name.UIApplicationDidEnterBackground,
//            object: nil)
//
//        do
//        {
//            // Try to load from persistence
//            self.todoItems = try [ToDoItem].readFromPersistence()
//        }
//        catch let error as NSError
//        {
//            if error.domain == NSCocoaErrorDomain && error.code == NSFileReadNoSuchFileError
//            {
//                NSLog("No persistence file found, not necesserially an error...")
//            }
//            else
//            {
//                let alert = UIAlertController(
//                    title: "Error",
//                    message: "Could not load the to-do items!",
//                    preferredStyle: .alert)
//
//                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//
//                self.present(alert, animated: true, completion: nil)
//
//                NSLog("Error loading from persistence: \(error)")
//            }
//        }
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    
    private var todoItems = ToDoItem.initializeList()
    
    override func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return todoItems.count
    }
    
    // Give list items a title, display checkmark depending on done state
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell_todo", for: indexPath)
        
        if indexPath.row < todoItems.count
        {
            let item = todoItems[indexPath.row]
            cell.textLabel?.text = item.title
            
            let accessory: UITableViewCellAccessoryType = item.done ? .checkmark : .none
            cell.accessoryType = accessory
        }
        
        return cell
    }
    
    // Toggle done flag
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row < todoItems.count
        {
            let item = todoItems[indexPath.row]
            item.done = !item.done
            
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
    }
    
    // Remove item from list
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if indexPath.row < todoItems.count
        {
            todoItems.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    @objc func didTapAddItemButton(_ sender: UIBarButtonItem)
    {
        // Create an alert
        let alert = UIAlertController(
            title: "New to-do item",
            message: "What do you need to do?",
            preferredStyle: .alert)
        
        // Add a text field to the alert for the new item's title
        alert.addTextField(configurationHandler: nil)

        // Add a "cancel" button to the alert
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        // Add an "OK" button to the alert
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler:
        { (_) in
            if let title = alert.textFields?[0].text
            {
                self.addNewToDoItem(title: title)
            }
        }))
        
        // Present the alert to user
        self.present(alert, animated: true, completion: nil)
    }
    
    private func addNewToDoItem(title: String)
    {
        // Index of new item is equal to the current count
        let newIndex = todoItems.count
        
        todoItems.append(ToDoItem(title: title))
        
        // Tell the table view a new row has been created
        tableView.insertRows(at: [IndexPath(row: newIndex, section: 0)], with: .top)
    }
    
//    @objc
//    public func applicationDidEnterBackground(_ notification: NSNotification)
//    {
//        do
//        {
//            try todoItems.writeToPersistence()
//        }
//        catch let error
//        {
//            NSLog("Error writing to persistence: \(error)")
//        }
//    }
}



































