//
//  ViewController.swift
//  MarketWatch
//
//  Created by Nunc on 06/02/19.
//  Copyright © 2019 NUNC. All rights reserved.
//

import UIKit

class LoginViewController : UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    subView.clipsToBounds = true
    subView.layer.cornerRadius = 5
        
        
     loginButton.clipsToBounds = true
     loginButton.layer.cornerRadius = loginButton.frame.height/2
        
     emailTxt.delegate = self
     passwordTxt.delegate = self
        
        
     Utilites.shared.bottomLineForTextFiled(txtFilled: emailTxt)
     Utilites.shared.bottomLineForTextFiled(txtFilled: passwordTxt)
        
  
    
        
    }
    override func viewWillAppear(_ animated: Bool)
    {
        UserDefaults.standard.set(false, forKey: "IsUserLogged")
        navigationController?.navigationBar.isHidden = true
       
    }


    @IBAction func loginBtnAction(_ sender: Any)
    {
        self.view.endEditing(true)
        
       let  isEmailinvaild = (Utilites.shared.isValidEmail(testStr: emailTxt.text as! String))
        
       if (emailTxt.text == "") {
            
            Utilites.shared.showAlertWithOneBtn(alertTitle: "Error!", alertMessage: "Please Enter Email Id" , OKActionHandler: {})
        }
        else if (isEmailinvaild == false)
        {
            Utilites.shared.showAlertWithOneBtn(alertTitle: "Error!", alertMessage: "Please Enter Valid Email" , OKActionHandler: {})
            
        }
       else  if (passwordTxt.text == "")
       {
            Utilites.shared.showAlertWithOneBtn(alertTitle: "Error!", alertMessage: "Please Enter password" , OKActionHandler: {})
            
        }
        else
       {
        
        
        
        let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let tabVC: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "myTabVc") as! UITabBarController
        tabVC.selectedIndex = 0
        UserDefaults.standard.set(true, forKey: "IsUserLogged") 
       
         self.navigationController?.pushViewController(tabVC, animated: true)
 
          
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        return true
    }
    
    
    
}

