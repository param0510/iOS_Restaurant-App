//Author: Paramveer
//Description: Utility class to handle repeated tasks and available globally

import Foundation
import CoreData
import UIKit

//format the currency
func getFormattedCurrency(_ amount: Double) -> String{
    return String(format: "$%.2f", amount)
}

//generates a unique ID forn data stored in core data
func generateUniqueId() -> String {
    return UUID().uuidString
}

//grab the current view context
func getAppViewContext() -> NSManagedObjectContext{
    return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
}
