//
//  ChatsViewController.swift
//  Practice
//
//  Created by Никита on 18.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit

class ChatsViewController: UIViewController {
    
   let newChatViewController = NewChatViewController()
        
    let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
    let data = ["1", "2", "3", "4"]
    var safeArea: UILayoutGuide!
    
    @objc func editChatTapped() {
        // edit calls
    }
    
    @objc func newChatTapped() {
        self.navigationController?.present(newChatViewController, animated: true, completion: nil)
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
        view.backgroundColor = .white
        
        self.navigationItem.title = "Chats"
        self.view.backgroundColor = .white
//        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editChatTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),style: .plain, target: self, action: #selector(newChatTapped))
        
        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search chats"
        navigationItem.searchController = search
    }
    
}

extension ChatsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
        cell.textLabel?.text = self.data[indexPath.row]
               
        return cell
    }
    
    func tableViewSetup() {
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TableViewCell")
    }
}

