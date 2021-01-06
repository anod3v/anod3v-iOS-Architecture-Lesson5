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
        Task(name: "выпить"),
        Task(name: "покурить"),
        Task(name: "еще выпить"),
        Task(name: "еще покурить")
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
        newViewController.tasks = [
        Task(name: "снова выпить"),
        Task(name: "снова покурить"),
        Task(name: "опять выпить"),
        Task(name: "опять покурить")
        ]
//        self.present(newViewController, animated: true, completion: nil)
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
}

