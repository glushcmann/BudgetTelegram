//
//  SettingsViewController.swift
//  Practice
//
//  Created by Никита on 18.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    let editViewController = EditViewController()
    
    let tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
    var safeArea: UILayoutGuide!
    let data = [["0,0", "0,1", "0,2"],["1,0", "1,1", "1,2"],]
    
    @objc func editTapped() {
        self.navigationController?.present(editViewController, animated: true, completion: nil)
    }

    func tableViewSetup() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
    
    override func loadView() {
        
        super.loadView()
        view.backgroundColor = .white
        safeArea = view.layoutMarginsGuide
        tableViewSetup()
        self.tableView.dataSource = self
        
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Settings"
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        
    }
}

extension SettingsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = self.data[indexPath.section][indexPath.row]
      
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.data.count
    }
}

class TableViewCell: UITableViewCell {

    override func prepareForReuse() {
          super.prepareForReuse()
          self.accessoryType = .none
      }

}

