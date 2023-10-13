//Author: Paramverr
//Description: View controller for Menu Items and details associated with them

import UIKit

class MenuListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    //menu item list
    var menuItemsList: [MenuItem] = []
    
    @IBOutlet var tableView: UITableView!
    
    // setting up context
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setting up notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(updateCartBadge), name: Notification.Name("updateCartBadge"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateUI), name: Notification.Name("MenuItemsListUpdated"), object: nil)
        
        // setting up tableview delegate and datasource
        tableView.dataSource = self
        tableView.delegate = self
        
        // updating UI with stored records
        updateUI()
    }
    
    // cart tabBarItem's badge is updated using this function
    @objc
    func updateCartBadge(){
        do{
            let cartItems: [Cart] = try context.fetch(Cart.fetchRequest())

            self.navigationController?.tabBarController?.tabBar.items![3].badgeValue = "\(cartItems.count)"
            
        }
        catch{
            print("Error updating badge value")
        }
    }
    
    // updates UI for everytime new data fetched
    @objc
    func updateUI(){
        do {
            try menuItemsList = context.fetch(MenuItem.fetchRequest())
            
            tableView.reloadData()
        }
        catch{
            print("Error in fetching data")
        }
    }
    
    // Total number of rows in table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemsList.count
    }
    
    // height for each row
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // fixed height
        return  120
    }
    
    // each cell is customized here. Filling in data for the labels
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // getting each cell as Downcasting it to MenuTableViewCell class object
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "tableViewCell", for: indexPath) as! MenuTableViewCell
        
        // getting each menuItem
        let menuItem = menuItemsList[indexPath.row]
        
        // populating cell with menuItem
        tableViewCell.menuItem = menuItem
        
        //populating cell labels
        tableViewCell.itemImageView.image = UIImage(named: menuItem.imageName!)
//        tableViewCell.itemImageView.layer.cornerRadius = 35
        tableViewCell.itemNameLabel.text = menuItem.name
        tableViewCell.itemPriceLabel.text = getFormattedCurrency(menuItem.price)
        
        return tableViewCell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // deselecting row for next time
        tableView.deselectRow(at: indexPath, animated: true)
        let menuItem = menuItemsList[indexPath.row]
        
        // Notes
        // Only instantiates the class not the viewcontroller. The class is just an extension to modify or add functionalities. It is not the actual view controller or "view" that will be loaded on screen. That's why it throws an error of "nil found when unwrapping optional"
//        let itemDetailsVC = ItemDetailsVC()
//        itemDetailsVC.dataRecieved = menuItem
  
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        if let detailsViewController = storyBoard.instantiateViewController(withIdentifier: "itemDetailsVC") as? ItemDetailsVC
        {
            // sending data to be displayed on the ItemDetailsVC labels
            detailsViewController.dataRecieved = menuItem
            
            navigationController?.pushViewController(detailsViewController, animated: true)
            
        }
    }
    
}

