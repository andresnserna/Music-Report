//
//  SignInViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit

class SignUpViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var txt_newUsername: UITextField!
    @IBOutlet weak var txt_newPassword: UITextField!
    @IBAction func btn_importLibrary(_ sender: UIButton) {
    }
    @IBAction func btn_createUser(_ sender: UIButton) {
    }
    
    @IBOutlet weak var lbl_uppercaseReq: UILabel!
    @IBOutlet weak var lbl_charCountReq: UILabel!
    @IBOutlet weak var lbl_specialCharReq: UILabel!
    @IBOutlet weak var lbl_numberReq: UILabel!
    
    

}
