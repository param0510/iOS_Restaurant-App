//Author: Paramveer
//Description: controller for item details

import Foundation
import UIKit

class ItemDetailsVC: UIViewController{
    
    @IBOutlet var itemImageView: UIImageView!
    @IBOutlet var itemNameLabel: UILabel!
    @IBOutlet var itemPriceLabel: UILabel!
    @IBOutlet var itemDescriptionLabel: UILabel!
    
    var dataRecieved: MenuItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let dr = dataRecieved
        {
            itemImageView.image = UIImage(named: dr.imageName!)
            itemNameLabel.text = dr.name
            itemPriceLabel.text = getFormattedCurrency(dr.price)
            itemDescriptionLabel.text = dr.desc
        }
        
    }
}
