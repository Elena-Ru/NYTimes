//
//  Article+CoreDataProperties.swift
//  NYTimes
//
//  Created by Елена Русских on 22.11.2022.
//
//

import Foundation
import CoreData


extension Article {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Article> {
        return NSFetchRequest<Article>(entityName: "Article")
    }

    @NSManaged public var id: Int64
    @NSManaged public var img: Data?
    @NSManaged public var title: String?
    @NSManaged public var url: String?

}

extension Article : Identifiable {

}
