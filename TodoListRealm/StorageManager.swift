//
//  StorageManager.swift
//  TodoListRealm
//
//  Created by Volodymyr Ostapyshyn on 15.09.2020.
//  Copyright © 2020 Volodymyr Ostapyshyn. All rights reserved.
//
import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveTasksList(_ tasksLists: [TasksList]) {
        try! realm.write {
            realm.add(tasksLists)
        }
    }
}

