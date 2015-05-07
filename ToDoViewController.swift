//
//  ToDoViewController.swift
//  Classy
//
//  Created by Gabriela Costales on 5/6/15.
//  Copyright (c) 2015 Gabriela Costales. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class ToDoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let textCellIdentifier = "AssignmentCell"
    
    var assignments = [Assignment]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var byDueDateButton: UIButton!
    @IBOutlet weak var byCourseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let request = NSFetchRequest(entityName: "Assignment")
        let sortDescriptor = NSSortDescriptor(key: "dueDate", ascending: true)
        let predicate = NSPredicate(format: "assignmentComplete == false")
        request.predicate = predicate
        if let fetchResults = managedObjectContext!.executeFetchRequest(request, error: nil) as? [Assignment] {
            assignments = fetchResults
        }
        
        //tableView.reloadData()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
     func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return assignments.count
    }
    
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AssignmentCell") as! UITableViewCell
        
        // Get the Course for this index
        let indieAssignment = assignments[indexPath.row]
        
        // Set the title of the cell to be the Course Name
        cell.textLabel?.text = indieAssignment.assignmentName
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.MediumStyle
        var dDateString = dateFormatter.stringFromDate(indieAssignment.dueDate)
        cell.detailTextLabel?.text = "\(indieAssignment.assignmentDescription) due \(dDateString)"
        
        if indieAssignment.assignmentComplete == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }

        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
            
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        var tappedItem = assignments[indexPath.row]
        
        if tappedItem.assignmentComplete == false {
            tappedItem.assignmentComplete = true
            cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            tappedItem.assignmentComplete = false
            cell!.accessoryType = UITableViewCellAccessoryType.None
        }
            
        tableView.reloadData()
        
    }

    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
