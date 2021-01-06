//
//  TaskService.swift
//  TaskManager
//
//  Created by Andrey on 06/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import Foundation

class TaskService {
    
    var rootTask: Task
    static let shared = TaskService()

    internal init() {
        self.rootTask = Task(name: "устроить вечеринку", childTasks: [
            Task(name: "пригласить друзей", childTasks: [
            Task(name: "устроить еще одну вечеринку"),
            Task(name: "устроить еще одну вечеринку")
            ]),
            Task(name: "напомнить им купить еду и напитки")
        ])
    }
}
