//
//  ViewController.swift
//  Learning Core Data
//
//  Created by Zabeehullah Qayumi on 9/13/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var items:[String] = []
    var cellID = "CellID"

    override func viewDidLoad() {
        
        super.viewDidLoad()
          
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Added", style: .plain, target: self, action: #selector(addItem))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        

    }
    @objc
    func addItem(_sender: AnyObject){
        
        let alertController = UIAlertController(title: "Add new Items", message: "Please, add your new items you wish to add ", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {  [unowned self] action in
            guard let textField = alertController.textFields?.first,
            let itemToAdd = textField.text else{return}
            self.items.append(itemToAdd)
            self.tableView.reloadData()
        }
        let cancelAction =  UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
       
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item
        return cell
    }


}

