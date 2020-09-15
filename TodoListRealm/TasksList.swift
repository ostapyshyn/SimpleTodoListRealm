//
//  TasksList.swift
//  TodoListRealm
//
//  Created by Volodymyr Ostapyshyn on 15.09.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//
import RealmSwift

class TasksList: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var date = Date()
    let tasks = List<Task>()
}
