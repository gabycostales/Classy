//
//  Assignment.swift
//  Classy
//
//  Created by Gabriela Costales on 5/6/15.
//  Copyright (c) 2015 Gabriela Costales. All rights reserved.
//

import Foundation
import CoreData

class Assignment: NSManagedObject {

    @NSManaged var assignmentComplete: NSNumber
    @NSManaged var assignmentDescription: String
    @NSManaged var assignmentName: String
    @NSManaged var dueDate: NSDate
    @NSManaged var relatedCourse: Course
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, assignmentName: String, assignmentDescription: String, dueDate: NSDate, relatedCourse: Course) -> Assignment {
        let newAssignment = NSEntityDescription.insertNewObjectForEntityForName("Assignment", inManagedObjectContext: moc) as! Assignment
        newAssignment.assignmentComplete = false
        newAssignment.assignmentDescription = assignmentDescription
        newAssignment.assignmentName = assignmentName
        newAssignment.dueDate = dueDate
        newAssignment.relatedCourse = relatedCourse
        
        return newAssignment
    }

}
