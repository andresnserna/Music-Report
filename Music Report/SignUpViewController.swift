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
    }
    
    @IBOutlet weak var txt_newUsername: UITextField!
    @IBOutlet weak var txt_newPassword: UITextField!
    @IBAction func btn_importLibrary(_ sender: UIButton) {
    }
    @IBAction func btn_createUser(_ sender: UIButton) {
        //read that username and password are not empty or nil
        if (txt_newPassword.text != nil && txt_newUsername.text != nil && txt_newPassword.text != "" && txt_newUsername.text != ""){
            addNewUser(newUsername: txt_newUsername.text!, newPassword: txt_newPassword.text!)
        }
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
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
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


}
