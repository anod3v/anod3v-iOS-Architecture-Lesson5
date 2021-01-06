//
//  ViewController.swift
//  TaskManager
//
//  Created by Andrey on 05/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private(set) var rootView = MainView()
    
    private(set) var tasks = [
        Task(name: "устроить вечеринку", childTasks: [
            Task(name: "пригласить друзей"),
            Task(name: "напомнить им купить еду и напитки")
        ]),
        Task(name: "устроить нормальную вечеринку", childTasks: [
            Task(name: "пригласить еще друзей"),
            Task(name: "напомнить им купить еще еды и напитков")
        ])
    ]
    
    init() {
        super.init(nibName: .none, bundle: .none)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        
        view = rootView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New task", style: .plain, target: self, action: #selector(addChildTask))
        
    }
    
    @objc func addChildTask() {
        
        let alert = UIAlertController(title: "Новая подзадача", message: "Укажите название задачи", preferredStyle: .alert)

        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.text = "Название задачи"
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
//            print("Text field: \(textField?.text)")
            let newTask = Task(name: textField!.text!)
            self.tasks.append(newTask)
        }))

        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    
    func setupViews() {
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        rootView.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseId)
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        let task = tasks[indexPath.row]
        cell.configure(task: task)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = ViewController()
        newViewController.tasks = self.tasks[indexPath.row].childTasks
        //        self.present(newViewController, animated: true, completion: nil)
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
}

