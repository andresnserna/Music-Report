//
//  SignInViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        activeUser = nil
        txt_newPassword.delegate = self

    }
    
    @IBOutlet weak var txt_newUsername: UITextField!
    @IBOutlet weak var txt_newPassword: UITextField!
    @IBAction func btn_importLibrary(_ sender: UIButton) {
    }
    @IBAction func btn_createUser(_ sender: UIButton) {
        // Check that username and password are not empty or nil
        guard let username = txt_newUsername.text, !username.isEmpty,
              let password = txt_newPassword.text, !password.isEmpty else {
            showAlert(title: "Error", message: "Please fill in all fields")
            return
        }
        
        // Validate password meets all requirements
        if !isPasswordValid(password) {
            showAlert(title: "Invalid Password", message: "Password must meet all requirements")
            return
        }
        
        //add the user to the User database
        addNewUser(newUsername: username, newPassword: password)
        
    }
    
    @IBOutlet weak var lbl_uppercaseReq: UILabel!
    @IBOutlet weak var lbl_charCountReq: UILabel!
    @IBOutlet weak var lbl_specialCharReq: UILabel!
    @IBOutlet weak var lbl_numberReq: UILabel!
    
    func addNewUser(newUsername: String, newPassword: String) {
        let newUser = User (context: context)
        newUser.username = newUsername
        newUser.password = newPassword
        
        //alert setup
        var alertTitle : String = ""
        var alertMessage : String = ""
        var alertController : UIAlertController!
        
        do {
            //save the usr
            try context.save()
            
            //set active user var
            activeUser = newUser.username
            
            //present successful pop up
            alertTitle = "Success!"
            alertMessage = "User " + newUsername + " added successfully!"
            alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            // Navigate AFTER user taps OK
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                // Segue to the landing page VC
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                let destinationViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController")
                self.present(destinationViewController, animated: true, completion: nil)
            }))
            
            present(alertController, animated: true, completion: nil)
            print("User added successfully")
            
        } catch {
            //preent error pop up
            alertTitle = "Error"
            alertMessage = "Error adding user: \(error)"
            alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            print("Error adding user: \(error)")
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        validatePassword(newText)
        return true
    }
    
    func isPasswordValid(_ password: String) -> Bool {
        let uppercaseRegex = ".*[A-Z]+.*"
        let numberRegex = ".*[0-9]+.*"
        let specialCharRegex = ".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]+.*"
        
        let hasUppercase = NSPredicate(format: "SELF MATCHES %@", uppercaseRegex).evaluate(with: password)
        let hasNumber = NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: password)
        let hasSpecialChar = NSPredicate(format: "SELF MATCHES %@", specialCharRegex).evaluate(with: password)
        let hasMinLength = password.count >= 12
        
        return hasUppercase && hasNumber && hasSpecialChar && hasMinLength
    }

    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }

    func validatePassword(_ password: String) {
        // Check for uppercase character
        let uppercaseRegex = ".*[A-Z]+.*"
        let hasUppercase = NSPredicate(format: "SELF MATCHES %@", uppercaseRegex).evaluate(with: password)
        
        // Check for number
        let numberRegex = ".*[0-9]+.*"
        let hasNumber = NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: password)
        
        // Check for special character
        let specialCharRegex = ".*[!@#$%^&*()_+\\-=\\[\\]{};':\"\\\\|,.<>\\/?]+.*"
        let hasSpecialChar = NSPredicate(format: "SELF MATCHES %@", specialCharRegex).evaluate(with: password)
        
        // Check for character count (12+)
        let hasMinLength = password.count >= 12
        
        // Update label colors based on validation
        lbl_uppercaseReq.textColor = hasUppercase ? .systemGreen : .systemGray
        lbl_numberReq.textColor = hasNumber ? .systemGreen : .systemGray
        lbl_specialCharReq.textColor = hasSpecialChar ? .systemGreen : .systemGray
        lbl_charCountReq.textColor = hasMinLength ? .systemGreen : .systemGray
    }

}
