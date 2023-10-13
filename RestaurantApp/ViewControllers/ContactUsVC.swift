//Author: Vpashan
//Description: Controller for the Contact us page

import UIKit
import MessageUI

class ContactUsVC: UIViewController, MFMailComposeViewControllerDelegate {

    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var messageField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //submit handler
    @IBAction func Submit(_ sender: Any) {
        
        // This one only works on actual mobile, so we used an alternative
        //email functionality to recieve the content
//        let toRecipients = ["topman@gmail.com"]
        
//        let mc: MFMailComposeViewController = MFMailComposeViewController()
//
//        mc.mailComposeDelegate = self
//
//        mc.setToRecipients(toRecipients)
//        mc.setSubject(nameField.text!)
        
        //composing the message with the details
//        mc.setMessageBody("Name: \(nameField.text!) \n\nEmail: \(emailField.text!) \n\nMessage: \(messageField.text!)", isHTML: false)
        
//        self.present(mc, animated: true, completion: nil)
        
        // Alternative - Just clears the form for a popup message
        
        if(nameField.text!.isEmpty || emailField.text!.isEmpty || messageField.text!.isEmpty){
            return
        }
        nameField.text = ""
        emailField.text = ""
        messageField.text = ""
        
        let alert = UIAlertController(title: "Message Sent", message: "Thanks for contacting us!", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        
        self.present(alert, animated: true)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        self.resignFirstResponder()
    }
    
    
    @IBAction func sendEmailBtnTapped(_ sender: Any) {
        showEmailPopup()
    }
    
    
    // This method only works on actual device and can't be properly tested on virtual device
    @IBAction func submit(_ sender: Any) {
        showEmailPopup()
    }
    func showEmailPopup() {
        if (!MFMailComposeViewController.canSendMail())
        {
            print("Can't Send Emails on this Device")
            return
        }
        
        let compose = MFMailComposeViewController()
        compose.mailComposeDelegate = self
        compose.setSubject(nameField.text!)
        compose.setToRecipients(["topman@gmail.com"])
        compose.setMessageBody("Name: \(nameField.text!) \n\nEmail: \(emailField.text!) \n\nMessage: \(messageField.text!)", isHTML: false)
        
        present(compose, animated: true)
    }
    
    //email handler
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        
        if let _ = error{
            print("Error Encountered by System")
            return
        }
        
        //possible outcomes and appropreate respopnses
        if(result == .sent){
            print("Email Sent")
        }
        else if(result == .failed)
        {
            print("Email Failed")
        }
        else if(result == .cancelled)
        {
            print("Email Cancelled")
        }
        else if(result == .saved)
        {
            print("Email Saved")
        }
        
        controller.dismiss(animated: true)
    }
}
