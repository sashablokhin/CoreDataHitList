//
//  ViewController.swift
//  CoreDataHitList
//
//  Created by Alexander Blokhin on 26.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {

    var peoples = [Person]()
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "New name", message: "Add a new name", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as UITextField
            //self.names.append(textField.text!)
            self.saveName(textField.text!)
            self.tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction!) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler { (textField: UITextField!) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert, animated: true, completion: nil)
    }
    
    let reuseIdentifier = "cell"
    
    func saveName(name: String) {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        /*
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        person.setValue(name, forKey: "name")
        */
            
        let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: managedContext)
        let person = Person(entity: entity!, insertIntoManagedObjectContext: managedContext)
        person.name = name

        try! managedContext.save()
            
        peoples.append(person)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }
    
    
    override func viewWillAppear(animated: Bool) { super.viewWillAppear(animated)
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
            
        let fetchRequest = NSFetchRequest(entityName:"Person")

        //let fetchedResults = try! managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        let fetchedResults = try! managedContext.executeFetchRequest(fetchRequest) as? [Person]
        
        if let results = fetchedResults {
            peoples = results
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return peoples.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)! as UITableViewCell
        
        let person = peoples[indexPath.row]
        //cell.textLabel!.text = person.valueForKey("name") as? String
        cell.textLabel!.text = person.name
        
        return cell
    }

}

