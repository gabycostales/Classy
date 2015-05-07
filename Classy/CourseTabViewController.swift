//
//  ViewController.swift
//  Classy
//
//  Created by Gabriela Costales
//  Copyright (c) 2015 Gabriela Costales. All rights reserved.
//

import UIKit
import CoreData

class CourseTabViewController: UITabBarController {
  
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        // Print it to the console
        println(managedObjectContext)
    
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: self.managedObjectContext!) as! Course
    }
  
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
}

