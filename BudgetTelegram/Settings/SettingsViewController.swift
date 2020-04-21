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
    let data = [["Saved Messages", "Recent Calls", "Devices", "Chat Folders"],
                ["Notifications and Sounds", "Privacy and Security", "Data and Storage", "Appearance", "Language", "Stickers"],
                ["Apple Watch"],
                ["Ask a Question", "BudgetTelegram FAQ"]
    ]
    
    @objc func editTapped() {
        self.navigationController?.present(editViewController, animated: true, completion: nil)
//        self.navigationController?.pushViewController(editViewController, animated: true)
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
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(systemName: "bookmark")
            case 1:
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(systemName: "phone")
             case 2:
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(systemName: "desktopcomputer")
            case 3:
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(systemName: "briefcase")
            default:
                cell.accessoryType = .none
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(systemName: "bell")
            case 1:
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(systemName: "lock")
            case 2:
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(systemName: "archivebox")
            case 3:
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(systemName: "pencil.and.outline")
            case 4:
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(systemName: "globe")
            case 5:
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(systemName: "rosette")
            default:
                cell.accessoryType = .none
            }
        case 2:
            cell.accessoryType = .disclosureIndicator
            cell.imageView?.image = UIImage(systemName: "clock")
        case 3:
            switch indexPath.row {
            case 0:
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(systemName: "text.bubble")
            case 1:
                cell.accessoryType = .disclosureIndicator
                cell.imageView?.image = UIImage(systemName: "questionmark")
            default:
                cell.accessoryType = .none
            }
        default:
            cell.accessoryType = .none
        }
        
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

