//
//  Cart+CoreDataProperties.swift
//  RestaurantApp
//
//  Created by param  on 2023-08-10.
//
//

import Foundation
import CoreData


extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart")
    }

    @NSManaged public var itemId: String? 
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var imageName: String?

}

extension Cart : Identifiable {

}
