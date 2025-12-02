//
//  SignInViewController.swift
//  Music Report
//
//  Created by Andrés Serna on 11/24/25.
//

import UIKit

class SignUpViewController: UIViewController {

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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
