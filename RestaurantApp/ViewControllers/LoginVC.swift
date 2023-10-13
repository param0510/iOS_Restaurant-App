//Author: Param
//Description: Controller to handle login

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var passwordTF: UITextField!
    @IBOutlet var usernameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func resetLoginForm(){
        usernameTF.text = ""
        passwordTF.text = ""
    }
    
    //check credentials to login
    @IBAction func LoginBtnTapped(_ sender: Any) {
        let username = usernameTF.text
        let password = passwordTF.text
        
        //empty the form
        resetLoginForm()
        
        //for simplicity for now proper hashing was not implemented to focus on functionality
        if (username == "admin" && password == "admin"){
            performSegue(withIdentifier: "LoginToDashboard", sender: nil)
            self.navigationController?.tabBarController?.hidesBottomBarWhenPushed = true
        }
        else{
            let alert = UIAlertController(title: "Oops!", message: "Wrong Credentials", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            
            self.present(alert, animated: true)
        }
    }
    
}
