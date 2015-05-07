//
//  Course.swift
//  Classy
//
//  Created by Gabriela Costales on 5/6/15.
//  Copyright (c) 2015 Gabriela Costales. All rights reserved.
//

import Foundation
import CoreData

class Course: NSManagedObject {

    @NSManaged var courseName: String
    @NSManaged var daysMeeting: String
    @NSManaged var professorName: String
    @NSManaged var timeMeeting: String
    @NSManaged var homeworkAndExams: NSOrderedSet
    
    class func createInManagedObjectContext(moc: NSManagedObjectContext, courseName: String, professorName: String, daysMeeting: String, timeMeeting: String) -> Course {
        let newCourse = NSEntityDescription.insertNewObjectForEntityForName("Course", inManagedObjectContext: moc) as! Course
        newCourse.courseName = courseName
        newCourse.professorName = professorName
        newCourse.daysMeeting = daysMeeting
        newCourse.timeMeeting = timeMeeting
        
        return newCourse
    }

}
