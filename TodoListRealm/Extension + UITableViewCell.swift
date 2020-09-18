//
//  Extension + UITableViewCell.swift
//  TodoListRealm
//
//  Created by Volodymyr Ostapyshyn on 18.09.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//

import UIKit

extension UITableViewCell {
    func configure(with tasksList: TasksList) {
        let currentTasks = tasksList.tasks.filter("isComplete = false")
        let completedTasks = tasksList.tasks.filter("isComplete = true")
        
        textLabel?.text = tasksList.name
        
        if !currentTasks.isEmpty {
            detailTextLabel?.text = "\(currentTasks.count)"
            detailTextLabel?.font = UIFont.systemFont(ofSize: 17)
            detailTextLabel?.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        } else if !completedTasks.isEmpty {
            detailTextLabel?.text = "✓"
            detailTextLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            detailTextLabel?.textColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else {
            detailTextLabel?.text = "0"
        }
    }
}
