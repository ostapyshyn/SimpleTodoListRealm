//
//  TasksListViewController.swift
//  TodoListRealm
//
//  Created by Volodymyr Ostapyshyn on 15.09.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit
import RealmSwift

class TasksListViewController: UITableViewController {

    var tasksLists: Results<TasksList>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
        tasksLists = realm.objects(TasksList.self)
//        let shopingList = TasksList()
//        shopingList.name = "Shopping List"
//
//        let moviesList = TasksList(value: ["Movies List", Date(), [["John Wick"], ["Tor", "", Date(), true]]])
//
//        let milk = Task()
//        milk.name = "Milk"
//        milk.note = "2L"
//
//        let bread = Task(value: ["Bread", "", Date(), true])
//        let apples = Task(value: ["name": "Apples", "note": "2Kg"])
//
//        shopingList.tasks.append(milk)
//        shopingList.tasks.insert(contentsOf: [bread, apples], at: 1)
//
//        DispatchQueue.main.async {
//            StorageManager.saveTasksList([shopingList, moviesList])
//        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func  addButtonPressed(_ sender: Any) {
        alerForAddAndUpdateList()
    }
    
    @IBAction func sortingList(_ sender: UISegmentedControl) {
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tasksLists.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListCell", for: indexPath)
        
        let tasksList = tasksLists[indexPath.row]
        cell.textLabel?.text = tasksList.name
        cell.detailTextLabel?.text = "\(tasksList.tasks.count)"
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let currentList = tasksLists[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { _, _ in
            
            StorageManager.deleteList(currentList)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        
        let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (_, _) in
            self.alerForAddAndUpdateList(currentList, complition: {
                tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        }
//
        let doneAction = UITableViewRowAction(style: .normal, title: "Done") { (_, _) in
            StorageManager.makeAllDone(currentList)
            tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        
        editAction.backgroundColor = .orange
        doneAction.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        return [deleteAction, doneAction, editAction]
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let tasksList = tasksLists[indexPath.row]
            let tasksVC = segue.destination as! TasksViewController
            tasksVC.currentTasksList = tasksList
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    

}


extension TasksListViewController {
    
    private func alerForAddAndUpdateList(_ listName: TasksList? = nil, complition: (() -> Void)? = nil) {
        
        var title = "New List"
        var doneButton = "Save"
        
        if listName != nil {
            title = "Edit List"
            doneButton = "Update"
        }
        
        let alert = UIAlertController(title: title, message: "Please insert new value", preferredStyle: .alert)
        var alertTextField: UITextField!
        
        let saveAction = UIAlertAction(title: doneButton, style: .default) { _ in
            guard let newList = alertTextField.text , !newList.isEmpty else { return }
            
            if let listName = listName {
                StorageManager.editList(listName, newListName: newList)
                if complition != nil { complition!() }
            } else {
                let tasksList = TasksList()
                tasksList.name = newList
                
                StorageManager.saveTasksList(tasksList)
                self.tableView.insertRows(at: [IndexPath(
                    row: self.tasksLists.count - 1, section: 0)], with: .automatic
                )
            }
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { textField in
            alertTextField = textField
            alertTextField.placeholder = "List Name"
        }
        
        if let listName = listName {
            alertTextField.text = listName.name
        }
        
        present(alert, animated: true)
    }
}

