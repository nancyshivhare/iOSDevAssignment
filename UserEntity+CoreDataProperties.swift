//
//  UserEntity+CoreDataProperties.swift
//  
//
//  Created by apple on 10/04/25.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var profileImageURL: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?

}
