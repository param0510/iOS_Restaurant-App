//Name: Arin
//Description: Controller for each cell in the cart table view

import UIKit

class CartTableViewCell: UITableViewCell {


    // Outlets
    @IBOutlet var cartItemImgView: UIImageView!
    @IBOutlet var cartItemPriceLabel: UILabel!
    @IBOutlet var cartItemNameLabel: UILabel!
    
    var cartItem: Cart!
    
    
    @IBAction func removeBtnTapped(_ sender: Any) {
        
        // getting app view context
        let context = getAppViewContext()
        
        do{
            //delete cart item from the list of stored items
            context.delete(cartItem)
            
            // saving the updated state
            try context.save()
            
            NotificationCenter.default.post(name: Notification.Name("cartItemsListUpdated"), object: nil)
        }
        catch{
            print("Error removing item from Cart")
            
        }
        
        // OLD
//        cartItems.remove(
//        if let index = cartItems.firstIndex(where: {$0.id == cartItemId}) {
//            cartItems.remove(at: index)
//        }

        
    }
}
