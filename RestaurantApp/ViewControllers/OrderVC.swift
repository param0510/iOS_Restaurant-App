//Name: Arin
//Description: handler for order view

import UIKit

class OrderVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // cartItems
    var cartItems: [Cart] = []
    
    //context
    let context = getAppViewContext()
    
    // tableview
    @IBOutlet var orderTableView: UITableView!
    
    // total bill amount
    var billTotal: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        orderTableView.dataSource = self
        orderTableView.delegate = self
        
        updateUI()
    
    }
    
    //update the UI
    func updateUI()
    {
        do{
            cartItems = try context.fetch(Cart.fetchRequest())
            
            orderTableView.reloadData()
        }
        catch{
            print("Unable to reload UI")
        }
    }
    
    //fixed height
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // need one extra row to display "bill total"
        return (cartItems.count + 1)
    }
    
    //actual table view handler for displaying each item in the cart when we hit checkout
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let orderCell = orderTableView.dequeueReusableCell(withIdentifier: "orderTableViewCell", for: indexPath) as! OrderTableViewCell
        
        // last row. Index starts from (0,0) => (rowNum, colNum)
        if(indexPath.row == (cartItems.count)){
            
            orderCell.orderItemNameLabel.font = UIFont.boldSystemFont(ofSize: 20)
            orderCell.orderItemPriceLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
            
            orderCell.orderItemNameLabel.text = "Bill Total"
            orderCell.orderItemPriceLabel.text = String(format: "$%.2f", billTotal)
            
            return orderCell
        }
        
        let orderItem = cartItems[indexPath.row]
        
        orderCell.orderItemNameLabel.text = orderItem.name
        orderCell.orderItemPriceLabel.text = String(format: "$%.2f", orderItem.price)
        
        billTotal += orderItem.price
        
        
        return orderCell
    }
    

    //Event handler for checkout button
    @IBAction func placeOrderBtnTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
        do{
            for i in cartItems{
                context.delete(i)
            }
            try context.save()
            NotificationCenter.default.post(name: Notification.Name("cartItemsListUpdated"), object: nil)
        }
        catch{
            print("Unable to clear cart!")
        }
        
    }
    
}
