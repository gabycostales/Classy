//
//  CourseCompleteTableViewController.swift
//  Classy
//
//  Created by Gabriela Costales on 5/6/15.
//  Copyright (c) 2015 Gabriela Costales. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class CourseCompleteTableViewController: UITableViewController {

    let textCellIdentifier = "completedAssignmentCell"
    
    var assignments = [Assignment]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var currentCourseName: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let request = NSFetchRequest(entityName: "Assignment")
        let coursePredicate = NSPredicate(format: "relatedCourse.courseName == %@", currentCourseName)
        let donePredicate = NSPredicate(format: "assignmentComplete == true")
        let predicate = NSCompoundPredicate(type: NSCompoundPredicateType.AndPredicateType, subpredicates: [coursePredicate, donePredicate])
        request.predicate = predicate
        if let fetchResults = managedObjectContext!.executeFetchRequest(request, error: nil) as? [Assignment] {
            assignments = fetchResults
        }
        
        tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return assignments.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("completedAssignmentCell", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...
        // Get the Course for this index
        let indieAssignment = assignments[indexPath.row]
        
        // Set the title of the cell to be the Course Name
        cell.textLabel?.text = indieAssignment.assignmentName
        cell.detailTextLabel?.text = indieAssignment.assignmentDescription
        
        if indieAssignment.assignmentComplete == true {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        var tappedItem = assignments[indexPath.row]
        println(tappedItem)
        
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
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
