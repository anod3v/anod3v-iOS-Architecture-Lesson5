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
    
    private(set) var task = TaskService.shared.rootTask
    
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
        rootView.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "\(task.name)"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "+", style: .done, target: self, action: #selector(addChildTask))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        rootView.tableView.reloadData()
    }
    
    @objc func addChildTask() {
        
        let alert = UIAlertController(title: "Новая подзадача", message: "Укажите название задачи", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.text = "Новая подзадача"
        }

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            let newTask = Task(name: textField!.text!)
            self.task.childTasks.append(newTask)
            self.rootView.tableView.reloadData()
        }))

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
        task.childTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseId, for: indexPath) as! TableViewCell
        cell.selectionStyle = .none
        let cellTask = task.childTasks[indexPath.row]
        let count = task.childTasks[indexPath.row].childTasks.count
        cell.configure(task: cellTask, subtasksCount: count)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newViewController = ViewController()
        newViewController.task = self.task.childTasks[indexPath.row]
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
}

