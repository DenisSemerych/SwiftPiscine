//
//  Article+CoreDataProperties.swift
//  
//
//  Created by Denis SEMERYCH on 4/11/19.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var content: String?
    @NSManaged public var creationDate: NSDate?
    @NSManaged public var image: NSData?
    @NSManaged public var language: String?
    @NSManaged public var modificationDate: NSDate?
    @NSManaged public var title: String?
    
    override public var description {
        get {
            guard let title = title, let creationDate = creationDate else {return "No info about object"}
            return ("Article: \(title) created on \(creationDate)")
        }
    }
}
