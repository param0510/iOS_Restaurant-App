//Author: Vpahsan
//Description: Controller for handling the form for creating a new menu item only accessible to admins

import UIKit

class MenuItemFormVC: UIViewController {

    
    var id: String!
    var menuItemForEdit: MenuItem?
    
    @IBOutlet var nameLabel: UITextField!
    @IBOutlet var imageNameLabel: UITextField!
    @IBOutlet var priceLabel: UITextField!
    @IBOutlet var descTextView: UITextView!
    
    // getting context object for CRUD
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if id == nil{
            id = generateUniqueId()
        }
        
        if let menuItem = menuItemForEdit{
            nameLabel.text = menuItem.name
            imageNameLabel.text = menuItem.imageName
            priceLabel.text = "\(menuItem.price)"
            descTextView.text = menuItem.desc
        }
    }
    
    //submit handler to add/edit the item in core data
    @IBAction func submitBtnTapped(_ sender: Any) {
        if menuItemForEdit == nil{
            // adding a new menu item
            let menuItem = MenuItem.init(context: context)
            menuItem.id = id
            menuItem.name = nameLabel.text
            menuItem.price = Double(priceLabel.text ?? "")!
            menuItem.imageName = imageNameLabel.text ?? "placeholder"
            menuItem.desc = descTextView.text
        }
        else{
            //edit handler
            if(nameLabel.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "") {
                menuItemForEdit?.name = nameLabel.text
            }
            if(priceLabel.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "") {
                menuItemForEdit?.price = Double(priceLabel.text ?? "1.00")!
            }
            if(imageNameLabel.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "") {
                menuItemForEdit?.imageName = imageNameLabel.text
            }
            else{
                menuItemForEdit?.imageName = "placeholder"
            }
            if(descTextView.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) != "") {
                menuItemForEdit?.desc = descTextView.text
            }
        }
        
        //save changes
        do{
            try context.save()
        }
        catch{
            print("Error in saving!!")
        }
        
        // pop out of this ViewController
        navigationController?.popViewController(animated: true)
        
        // Send out notification for UI update
        NotificationCenter.default.post(name: Notification.Name("MenuItemsListUpdated"), object: nil)
    }
    
}
