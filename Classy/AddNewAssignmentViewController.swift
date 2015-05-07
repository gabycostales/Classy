//
//  AddNewAssignmentViewController.swift
//  Classy
//
//  Created by Gabriela Costales on 5/6/15.
//  Copyright (c) 2015 Gabriela Costales. All rights reserved.
//

import UIKit
import Foundation
import CoreData

class AddNewAssignmentViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descTextField: UITextField!
    @IBOutlet weak var coursePicker: UIPickerView! = UIPickerView()
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var pCourseText: UITextField!
    
    var courses = [Course]()
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func savePressed(sender: UIBarButtonItem) {
        
        if (titleTextField.text == "" || descTextField.text == "") {
            
            let alertController = UIAlertController(title: "Error!", message: "All fields are required.", preferredStyle: UIAlertControllerStyle.Alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
            
        } else {
            
            var selectedCourseName = pCourseText.text
        
            let request = NSFetchRequest(entityName: "Course")
            let predicate = NSPredicate(format: "courseName == %@", selectedCourseName)
            request.predicate = predicate
            
            if let fetchResult = managedObjectContext!.executeFetchRequest(request, error: nil) as? [Course] {
                
                var selectedCourse = fetchResult[0]
                
                let newAssignment = Assignment.createInManagedObjectContext(managedObjectContext!, assignmentName: titleTextField.text, assignmentDescription: descTextField.text, dueDate: datePicker.date, relatedCourse: selectedCourse)
                
                var error: NSError?
                
                managedObjectContext?.save(&error)
                                
                if let err = error {
                    let alertController = UIAlertController(title: "Oops!", message: err.localizedFailureReason, preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel, handler: nil)
                    alertController.addAction(okAction)
                    presentViewController(alertController, animated: true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "Success!", message: "The assignment has been successfully added!", preferredStyle: UIAlertControllerStyle.Alert)
                    let okAction = UIAlertAction(title: "Add Another", style: UIAlertActionStyle.Cancel, handler: nil)
                    alertController.addAction(okAction)
                    presentViewController(alertController, animated: true, completion: nil)
                    titleTextField.text = ""
                    descTextField.text = ""
                }

            }
            
            
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        pCourseText.hidden = true;
        
        coursePicker.delegate = self
        let courseRequest = NSFetchRequest(entityName: "Course")
        
        if let courseFetchResults = managedObjectContext!.executeFetchRequest(courseRequest, error: nil) as? [Course] {
            courses = courseFetchResults
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return courses.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String
    {
        return courses[row].courseName
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        pCourseText.text = courses[row].courseName
    }
    
    func textFieldShouldReturn(userText: UITextField!) -> Bool {
        userText.resignFirstResponder()
        return true;
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
