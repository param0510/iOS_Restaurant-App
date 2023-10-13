//
//  Order.swift
//  restaurentapp
//
//  Created by Arin Dhiman on 8/8/23.
//

import Foundation

class Order {
    public private(set) var orderId: String;
    public var items: [MenuItem];
    
    
    // Implement later
//    public private(set) var placedBy: String{
//        didSet{
//            if(placedBy.count == 0 || placedBy.trimmingCharacters(in: .whitespaces) == "") {
//                placedBy = oldValue
//            }
//        }
//    };
//    public private(set) var active: Bool = true;
//
//    var total: Double{
//        var s: Double = 0.0;
//        for item in items{
//            s += item.price;
//        }
//        return s;
//    }
//
//    public init(orderId: String, items: [MenuItem], placedBy: String){
//        self.orderId = orderId;
//        self.items = items;
//        self.placedBy = placedBy;
//    }
    
    init(orderId: String, items: [MenuItem]) {
        self.orderId = orderId
        self.items = items
    }
}
