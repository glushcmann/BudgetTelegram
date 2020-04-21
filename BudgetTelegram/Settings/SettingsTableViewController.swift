//
//  SettingsTableViewController.swift
//  Practice
//
//  Created by Никита on 19.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

//import UIKit
//
//class SettingsTableViewController: UIViewController {
//
//    let tableView = UITableView.init(frame: CGRect.zero, style: .insetGrouped)
//    var safeArea: UILayoutGuide!
//    let data = [["0,0", "0,1", "0,2"],["1,0", "1,1", "1,2"],]
//    
//    func tableViewSetup() {
//        
//        view.addSubview(tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
//            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
//            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
//        ])
//        
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
//    }
//    
//    override func loadView() {
//      super.loadView()
//      view.backgroundColor = .white
//      safeArea = view.layoutMarginsGuide
//      tableViewSetup()
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.tableView.dataSource = self
//    }
//}
//
//extension SettingsTableViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.data[section].count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
//        cell.textLabel?.text = self.data[indexPath.section][indexPath.row]
//      
//        return cell
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return self.data.count
//    }
//}
//
//class TableViewCell: UITableViewCell {
//
//    override func prepareForReuse() {
//          super.prepareForReuse()
//          self.accessoryType = .none
//      }
//
//}
