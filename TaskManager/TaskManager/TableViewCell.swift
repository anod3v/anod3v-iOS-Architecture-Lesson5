//
//  TableViewCell.swift
//  TaskManager
//
//  Created by Andrey on 02/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseId: String = "TableViewCell"
    
    private(set) var taskNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var subtasksCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.numberOfLines = 1
        label.textAlignment = .center
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addViews() {
        contentView.addSubview(taskNameLabel)
        contentView.addSubview(subtasksCountLabel)
    }
    
    func configure(task: Task, subtasksCount: Int) {
        taskNameLabel.text = task.name
        subtasksCountLabel.text = "\(subtasksCount)"
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            taskNameLabel.centerYAnchor.constraint(equalTo: subtasksCountLabel.centerYAnchor),
            taskNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            taskNameLabel.widthAnchor.constraint(equalToConstant: 200),
            taskNameLabel.heightAnchor.constraint(equalToConstant: 30),
            
            subtasksCountLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            subtasksCountLabel.widthAnchor.constraint(equalToConstant: 200),
            subtasksCountLabel.leadingAnchor.constraint(equalTo: taskNameLabel.trailingAnchor, constant: 20),
            subtasksCountLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
}
