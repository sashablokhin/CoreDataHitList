//
//  ViewController.swift
//  CoreDataHitList
//
//  Created by Alexander Blokhin on 26.02.16.
//  Copyright © 2016 Alexander Blokhin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var names = [String]()
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addButtonPressed(sender: AnyObject) {
        let alert = UIAlertController(title: "New name", message: "Add a new name", preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save", style: .Default) { (action: UIAlertAction!) -> Void in
            let textField = alert.textFields![0] as UITextField
            self.names.append(textField.text!)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "The List"
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier)! as UITableViewCell
        cell.textLabel!.text = names[indexPath.row]
        
        return cell
    }

}

