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
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.numberOfLines = 1
        label.sizeToFit()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) var taskDurationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
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
        contentView.addSubview(taskDurationLabel)
    }
    
    func configure(task: Task) {
        taskNameLabel.text = task.name

    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            taskNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            taskNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            taskNameLabel.widthAnchor.constraint(equalToConstant: 200),
            taskNameLabel.heightAnchor.constraint(equalToConstant: 130),
            
            taskDurationLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor),
            taskDurationLabel.widthAnchor.constraint(equalToConstant: 200),
            taskDurationLabel.leadingAnchor.constraint(equalTo: taskNameLabel.trailingAnchor, constant: 20),
            taskDurationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 20),
        ])
    }
}
