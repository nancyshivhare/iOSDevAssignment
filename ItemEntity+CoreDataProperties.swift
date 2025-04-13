//
//  ItemEntity+CoreDataProperties.swift
//  
//
//  Created by apple on 12/04/25.
//
//

import Foundation
import CoreData


extension ItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemEntity> {
        return NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    }

    @NSManaged public var capacity: String?
    @NSManaged public var color: String?
    @NSManaged public var name: String?
    @NSManaged public var id: String?

}
