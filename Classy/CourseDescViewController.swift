//
//  CourseDescViewController.swift
//  Classy
//
//  Created by Gabriela Costales on 5/6/15.
//  Copyright (c) 2015 Gabriela Costales. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CourseDescViewController: UIViewController {
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    var selectedCourseName: String = ""
    
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseMeetingsLabel: UILabel!
    @IBOutlet weak var courseInstructorLabel: UILabel!
    
    @IBAction func backButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Print it to the console
        println(selectedCourseName)
        
        let request = NSFetchRequest(entityName: "Course")
        let predicate = NSPredicate(format: "courseName == %@", selectedCourseName)
        
        request.predicate = predicate
        if let fetchResult = managedObjectContext!.executeFetchRequest(request, error: nil) as? [Course] {
            // should only return 1 course
            println(fetchResult[0])
            var course = fetchResult[0]
            courseNameLabel.text = course.courseName
            courseMeetingsLabel.text = course.daysMeeting + " " + course.timeMeeting
            courseInstructorLabel.text = course.professorName
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "toCourseDescTabBarC" {
            
            var tabBarC = segue.destinationViewController as! CourseTabViewController
            var desView1 = tabBarC.viewControllers?.first as! CoursePendingTableViewController
            var desView2 = tabBarC.viewControllers?[1] as! CourseCompleteTableViewController
            
            desView1.currentCourseName = selectedCourseName
            desView2.currentCourseName = selectedCourseName
            
        }

    }
    
}
