//
//  CitiesListMainView.swift
//  WhiteNFluffyTestTask
//
//  Created by Andrey on 05/01/2021.
//  Copyright © 2021 Andrey Anoshkin. All rights reserved.
//

import UIKit

class MainView: UIView {
    
    private(set) var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    init() {
        super.init(frame: .zero)
        addSubviews()
        setNeedsUpdateConstraints()
    }
    
    func addSubviews() {
        self.addSubview(tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
    NSLayoutConstraint.activate([
        
        tableView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
        tableView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
        tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
        tableView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
    ])
        super.updateConstraints()
    }
}
