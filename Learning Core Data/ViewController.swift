//
//  ViewController.swift
//  Learning Core Data
//
//  Created by Zabeehullah Qayumi on 9/13/18.
//  Copyright © 2018 Zabeehullah Qayumi. All rights reserved.
//
//

import UIKit
import CoreData

class ViewController: UITableViewController {
    
    var items:[NSManagedObject] = []
    
    var cellID = "CellID"

    override func viewDidLoad() {
        
        super.viewDidLoad()
          
        view.backgroundColor = .white
        navigationController?.navigationBar.barTintColor = UIColor(red: 21/255, green: 101/255, blue: 192/255, alpha: 1)
        navigationController?.navigationBar.tintColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addItem))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Item")
        do{
            items = try managedContext.fetch(fetchRequest)
        }catch{
            print("Could not load data from database \(error.localizedDescription)")
        }
    }
    @objc
    func addItem(_sender: AnyObject){
        
        let alertController = UIAlertController(title: "Add new Items", message: "Please, add your new items you wish to add ", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {  [unowned self] action in
            guard let textField = alertController.textFields?.first,
            let itemToAdd = textField.text else{return}
            self.save(itemToAdd)
            self.tableView.reloadData()
        }
        let cancelAction =  UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
       
    }
    
    func save(_ itemName: String){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Item", in: managedContext)!
        let item = NSManagedObject(entity: entity, insertInto: managedContext)
        item.setValue(itemName, forKey: "itemName")
        
        do{
            try managedContext.save()
            items.append(item)
            tableView.reloadData()
        }catch{
            print("Could not save data ! \(error.localizedDescription)")
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.value(forKeyPath: "itemName") as? String
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            items.remove(at: indexPath.row)
            self.tableView.reloadData()
        }
    }


}

