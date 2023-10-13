//
//  MenuItem+CoreDataProperties.swift
//  RestaurantApp
//
//  Created by param  on 2023-08-10.
//
//

import Foundation
import CoreData


extension MenuItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MenuItem> {
        return NSFetchRequest<MenuItem>(entityName: "MenuItem")
    }

    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var imageName: String?
    @NSManaged public var desc: String?
    @NSManaged public var id: String?

}

extension MenuItem : Identifiable {

}
