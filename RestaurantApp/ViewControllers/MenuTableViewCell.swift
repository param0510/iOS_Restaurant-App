//Name: Paramveer
//Description: Controller for menu item details

import UIKit

class MenuTableViewCell: UITableViewCell {

    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemPriceLabel: UILabel!
    @IBOutlet var itemNameLabel: UILabel!
    
    var menuItem: MenuItem!
    
    
    @IBAction func addBtnTapped(_ sender: Any) {
        
        // viewContext to access stored data
        let context = getAppViewContext()
        
        do
        {
            // getting the cart from context
            let cart = Cart(context: context)
            
            cart.itemId = menuItem.id
            cart.imageName = menuItem.imageName
            cart.name = menuItem.name
            cart.price = menuItem.price
            
            // saving context
            try context.save()
            
            //Sending out notifications
            NotificationCenter.default.post(name: Notification.Name("updateCartBadge"), object: nil)
            
            NotificationCenter.default.post(name: Notification.Name("cartItemsListUpdated"), object: nil)
            
        }
        catch{
            print("Error adding item to cart")
        }
    }
    

}
