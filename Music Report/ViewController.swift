//
//  ViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context = appDelegate.persistentContainer.viewContext
var activeUser : String? = nil

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        activeUser = nil
    }

    @IBOutlet weak var txt_username: UITextField!
    @IBOutlet weak var txt_password: UITextField!
    @IBAction func btn_musicSignUp(_ sender: UIButton) {
    }
    @IBAction func btn_musicSignIn(_ sender: UIButton) {
        var data = [User]()
        var alertTitle : String = ""
        var alertMessage : String = ""
        var alertController : UIAlertController!
        
        do {
            data = try context.fetch(User.fetchRequest())
            var userFound = false
            
            for existingUser in data {
                if (existingUser.username == txt_username.text && existingUser.password == txt_password.text) {
                    let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    let destinationViewController: UIViewController = mainStoryboard.instantiateViewController(withIdentifier: "LandingPage")
                    self.present(destinationViewController, animated: true, completion: nil)
                    activeUser = existingUser.username
                    print("DEBUG: Found Username: \(existingUser.username ?? "NONE")")
                    userFound = true
                    break  // Exit loop once we find a match
                }
            }
            
            if !userFound {
                print("DEBUG: No matching username/password found")
                alertTitle = "Incorrect"
                alertMessage = "Username or password incorrect"
                alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }
        catch {
            // Present error pop up
            alertTitle = "Error"
            alertMessage = "Error fetching data: \(error)"
            alertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            print("Error fetching data: \(error)")
        }
    }
    
}

