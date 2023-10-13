//Name: Arin
//Description: controller for Cart view

import UIKit

class CartVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var emptyCartImageView: UIImageView!
    @IBOutlet var cartTableView: UITableView!
    
    // getting context
    let context = getAppViewContext()
    
    var cartItems: [Cart] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up tableview delegate and datasource
        cartTableView.dataSource = self
        cartTableView.delegate = self
        
        // checking for empty cart
        if cartItems.isEmpty{
            emptyCartImageView.isHidden = false
        }
        else{
            amountLabel.text = getTotalCartAmount()
        }
        
        // notification observer for cartItemsList updates
        NotificationCenter.default.addObserver(self, selector: #selector(updateCartUI), name: Notification.Name("cartItemsListUpdated"), object: nil)
        
        // updating data from core database
        updateCartUI()
    }
    
    //handling UI updates
    func updateData(){
        do{
            cartItems = try context.fetch(Cart.fetchRequest())
        }
        catch{
            print("Error loading cart from Core Data")
        }
    }
    
    @objc
    func updateCartUI(){
        //dynamically adjust the view in response to user inputs
        updateData()
        if(cartItems.isEmpty){
            // show empty cart Image - Block other views
            emptyCartImageView.isHidden = false
            
            // resetting the tabBarItem badgeValue
            self.navigationController?.tabBarItem.badgeValue = nil
        }
        else{
            // Hiding the empty cart image
            emptyCartImageView.isHidden = true
            
            // sending notification to update badge value
            NotificationCenter.default.post(name: Notification.Name("updateCartBadge"), object: nil)
    
            // Notes
            // Methods to change tabBarItem badgeValue
            //self.navigationController?.tabBarController?.tabBar.items![1].badgeValue = "T"
            
            // self.navigationController?.tabBarItem.badgeValue = "N"
        }
        
        // reload the table view
        cartTableView.reloadData()
        amountLabel.text = getTotalCartAmount()
    }
    
    // tableView DataSources
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartItems.count
    }
    
    
    //actual table view to display cvart items
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartCell = tableView.dequeueReusableCell(withIdentifier: "cartTableViewCell", for: indexPath) as! CartTableViewCell
        
        let cartItem = cartItems[indexPath.row]
        
        // sending in the MenuItem Object
        cartCell.cartItem = cartItem
        
        cartCell.cartItemNameLabel.text = cartItem.name
        cartCell.cartItemPriceLabel.text = getFormattedCurrency(cartItem.price)
        cartCell.cartItemImgView.image = UIImage(named: cartItem.imageName ?? "placeholder")
        
        
        return cartCell
    }
    
    // tableview delegates
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // fixed height
        return  120
    }
    
    // getting total Calculated amount for the cart
    func getTotalCartAmount() -> String {
        var totalAmount: Double = 0.0
        for item in cartItems{
            totalAmount += item.price
        }
        return getFormattedCurrency(totalAmount)
    }
    
    // deinitializer
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
}
