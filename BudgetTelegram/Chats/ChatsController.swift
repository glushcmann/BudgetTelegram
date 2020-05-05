//
//  ChatsController.swift
//  BudgetTelegram
//
//  Created by Никита on 30.04.2020.
//  Copyright © 2020 Nikita Glushchenko. All rights reserved.
//

import UIKit
import CoreData

class ChatsController: UICollectionViewController, UICollectionViewDelegateFlowLayout, NSFetchedResultsControllerDelegate {

    var blockOperations = [BlockOperation]()
    
    lazy var fetchedResultController: NSFetchedResultsController<NSFetchRequestResult> = {
           let request =  NSFetchRequest<NSFetchRequestResult>(entityName: "User")
            request.sortDescriptors = [NSSortDescriptor(key: "lastMessage.date", ascending: false)]
           request.predicate = NSPredicate(format: "lastMessage != nil")
           let delegate = UIApplication.shared.delegate as! AppDelegate
           let contex = delegate.persistentContainer.viewContext
           let fetch = NSFetchedResultsController(fetchRequest: request, managedObjectContext: contex, sectionNameKeyPath: nil, cacheName: nil)
           fetch.delegate = self
           return fetch
       }()

    private let cellID = "cellID"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tabBarController?.tabBar.isHidden = false 
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Chats"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editChatTapped))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),style: .plain, target: self, action: #selector(newChatTapped))

        let search = UISearchController(searchResultsController: nil)
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search for messages or users"
        navigationItem.searchController = search
        
        collectionView?.backgroundColor = .systemBackground
        collectionView?.alwaysBounceVertical = true
        collectionView?.register(MessageCell.self, forCellWithReuseIdentifier: cellID)
        
        setupData()
        
        do {
            try fetchedResultController.performFetch()
        } catch let error {
            print(error)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Mark", style: .plain, target: self , action: #selector(addMark))
    }
    
    @objc func editChatTapped() {
        // edit calls
    }

    @objc func newChatTapped() {
        self.navigationController?.present(NewChatViewController(), animated: true, completion: nil)
    }
    
    @objc func addMark() {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
         let contex = delegate.persistentContainer.viewContext
        
        let mark = NSEntityDescription.insertNewObject(forEntityName: "User" , into: contex ) as! User
        mark.name = "Mark"
        mark.profileImage = "1"
        
        ChatsController.createMessageWithText(text: "hi", user: mark, minutesAgo: 0, context: contex)
    }
    
}

extension ChatsController {
    
    // fetch

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        if type == .insert {
            blockOperations.append(BlockOperation(block: {
                self.collectionView.insertItems(at: [newIndexPath!])
            }))
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates({
            
            for operation in self.blockOperations {
                operation.start()
            }
            
        }, completion: { (completed) in
            
            let lastItem = self.fetchedResultController.sections![0].numberOfObjects - 1
            let indexPath = IndexPath(item: lastItem, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .bottom, animated: true)
            
        })
    }
    
    //collectionview
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MessageCell
        
        let friend = fetchedResultController.object(at: indexPath) as! User
        
        cell.message = friend.lastMessage
        
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = fetchedResultController.sections?[section].numberOfObjects {
            return count
        }
        return 0
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 80)
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let layout = UICollectionViewFlowLayout()
        let controller = ChatLogController(collectionViewLayout: TabBarController.layout)
        let friend = fetchedResultController.object(at: indexPath) as! User
        controller.friend = friend
        navigationController?.pushViewController(controller, animated: true)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
