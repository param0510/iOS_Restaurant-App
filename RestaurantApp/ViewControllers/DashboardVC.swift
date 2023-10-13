//Author: Vpashan
//Description: Controller for landing view once logged in

import UIKit

class DashboardVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // Outlets
    @IBOutlet var dbTableView: UITableView!
    
    // getting context object for CRUD
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    // update this using context
    var menuItemsList: [MenuItem] = []
    
    // REMOVE
    //    [MenuItem(id: 1, name: "item1", description: "desc", price: 34.21),MenuItem(id: 1, name: "item1", description: "desc", price: 34.21)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // table setup
        dbTableView.dataSource = self
        dbTableView.delegate = self
        
        
        // setting up notification observer
        NotificationCenter.default.addObserver(self, selector: #selector(reloadUI), name: Notification.Name("MenuItemsListUpdated"), object: nil)
        
        updateData()
    }
    
    @objc
    func reloadUI(){
        updateData()
    }
    
    
    // function - refreshes the menuItems for the UI
    func updateData(){
        do{
            try menuItemsList = context.fetch(MenuItem.fetchRequest())
            
            DispatchQueue.main.async {
                self.dbTableView.reloadData()
            }
        }
        catch{
            print("Error in fetching data")
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        menuItemsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dbTableCell = dbTableView.dequeueReusableCell(withIdentifier: "dbTableViewCell", for: indexPath) as! DashboardTableViewCell
        
        let menuItem = menuItemsList[indexPath.row]
        
        dbTableCell.dbItemImgView.image = UIImage(named: menuItem.imageName!)
        dbTableCell.dbItemNameLabel.text = menuItem.name
        dbTableCell.dbItemPriceLabel.text = getFormattedCurrency(menuItem.price)
        
        return dbTableCell
    }
    
    // Trailing Slide Action Event handler - Delete
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let contextualAction = UIContextualAction(style: .destructive, title: "Delete") { _,_,_  in
            // Delete Item
            
            // getting the object
            let menuItem = self.menuItemsList[indexPath.row]
            
            
            do{
                // deleting it using context
                self.context.delete(menuItem)
                
                // saving the update to core data
                try self.context.save()
                
                // reloading the UI
                NotificationCenter.default.post(name: Notification.Name("MenuItemsListUpdated"), object: nil)
//                self.reloadUI()
            }
            catch{
                print("Error in deleting")
            }
            
        }
        
        return UISwipeActionsConfiguration(actions: [contextualAction])
    }
    
    // Add button tap  action
    @IBAction func addBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "addItemSegue", sender: nil)
    }
    
    
    // Row selected/tapped in dbTableView - Update
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let menuItem = menuItemsList[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        if let menuItemFormVC = storyboard.instantiateViewController(withIdentifier: "menuItemFormVC") as? MenuItemFormVC{
            menuItemFormVC.id = menuItem.id
            menuItemFormVC.menuItemForEdit = menuItem
            
            // pushing the new view
            navigationController?.pushViewController(menuItemFormVC, animated: true)
        }
    }
}
