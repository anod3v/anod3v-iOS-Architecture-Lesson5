//
//  Task.swift
//  TaskManager
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import Foundation

protocol Taskable {
    var name: String { get set }
    var childTask: Task? { get set }
    func createChildTask(name: String)
    
}

class Task: Taskable {
    
    var name: String
    
    var childTask: Task?
    
    func createChildTask(name: String) {
        childTask = Task(name: name)
    }
    
    init(name: String) {
        self.name = name
        self.childTask = nil
    }
}


