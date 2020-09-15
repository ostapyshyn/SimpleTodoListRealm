//
//  TasksListViewController.swift
//  TodoListRealm
//
//  Created by Volodymyr Ostapyshyn on 15.09.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit

class TasksListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let shopingList = TasksList()
        shopingList.name = "Shopping List"
        
        let moviesList = TasksList(value: ["Movies List", Date(), [["John Wick"], ["Tor", "", Date(), true]]])
        
        let milk = Task()
        milk.name = "Milk"
        milk.note = "2L"
        
        let bread = Task(value: ["Bread", "", Date(), true])
        let apples = Task(value: ["name": "Apples", "note": "2Kg"])
        
        shopingList.tasks.append(milk)
        shopingList.tasks.insert(contentsOf: [bread, apples], at: 1)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    @IBAction func editButtonPressed(_ sender: Any) {
    }
    
    @IBAction func  addButtonPressed(_ sender: Any) {
        alerForAddAndUpdateList()
    }
    
    @IBAction func sortingList(_ sender: UISegmentedControl) {
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskListCell", for: indexPath)

       
        

        return cell
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
    
    private func alerForAddAndUpdateList() {
        
        let alert = UIAlertController(title: "New List", message: "Please insert new value", preferredStyle: .alert)
        var alertTextField: UITextField!
        
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            guard let text = alertTextField.text , !text.isEmpty else { return }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        alert.addTextField { textField in
            alertTextField = textField
            alertTextField.placeholder = "List Name"
        }
        
        present(alert, animated: true)
    }
}

