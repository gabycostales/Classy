//
//  AddNewCourseViewController.swift
//  Classy
//
//  Created by Gabriela Costales on 5/6/15.
//  Copyright (c) 2015 Gabriela Costales. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class AddNewCourseViewController: UIViewController {

    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    @IBOutlet weak var cNameText: UITextField!
    
    @IBOutlet weak var cDaysText: UITextField!
    
    @IBOutlet weak var cTimeText: UITextField!
    
    @IBOutlet weak var cInstructorText: UITextField!
    
    @IBAction func saveCourse(sender: UIButton) {
        
        if (cNameText.text == "" || cDaysText.text == "" || cTimeText.text == "" || cInstructorText.text == "") {
            
            let alertController = UIAlertController(title: "Error!", message: "All fields are required.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            
            let newCourse = Course.createInManagedObjectContext(managedObjectContext!, courseName: cNameText.text, professorName: cInstructorText.text, daysMeeting: cDaysText.text, timeMeeting: cTimeText.text)
            
            var error: NSError?
            
            managedObjectContext?.save(&error)
            
            println(newCourse)
            
            if let err = error {
                let alertController = UIAlertController(title: "Oops!", message: err.localizedFailureReason, preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                alertController.addAction(okAction)
                presentViewController(alertController, animated: true, completion: nil)
            } else {
                let alertController = UIAlertController(title: "Success!", message: "The Course has been successfully added!", preferredStyle: UIAlertControllerStyle.Alert)
                let okAction = UIAlertAction(title: "Add Another", style: UIAlertActionStyle.Cancel, handler: nil)
                alertController.addAction(okAction)
                presentViewController(alertController, animated: true, completion: nil)
                cNameText.text = ""
                cDaysText.text = ""
                cTimeText.text = ""
                cInstructorText.text = ""
            }
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
