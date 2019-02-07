//
//  ProfileViewController.swift
//  MarketWatch
//
//  Created by NUNC on 2/6/19.
//  Copyright © 2019 NUNC. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet var nameTxf: UITextField!
    @IBOutlet var addressTxf: UITextField!
    @IBOutlet var emailTxf: UITextField!
    @IBOutlet var userIdTxf: UITextField!
    
    @IBOutlet var saveBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          nameTxf.font = UIFont.init(name:AppSubHeadingFont , size: 15);
          addressTxf.font = UIFont.init(name:AppSubHeadingFont , size: 15);
          emailTxf.font = UIFont.init(name:AppSubHeadingFont , size: 15);
          userIdTxf.font = UIFont.init(name:AppSubHeadingFont , size: 15);
        Utilites.shared.bottomLineForTextFiled(txtFilled: nameTxf)
        Utilites.shared.bottomLineForTextFiled(txtFilled: addressTxf)
        Utilites.shared.bottomLineForTextFiled(txtFilled: emailTxf)
        Utilites.shared.bottomLineForTextFiled(txtFilled: userIdTxf)
        Utilites.shared.textFieldsLeftIconDesign(txtFilled: nameTxf, imgName: "NameIcon")
        Utilites.shared.textFieldsLeftIconDesign(txtFilled: addressTxf, imgName: "AddressIcon")
        Utilites.shared.textFieldsLeftIconDesign(txtFilled: emailTxf, imgName: "EmailIcon")
        Utilites.shared.textFieldsLeftIconDesign(txtFilled: userIdTxf, imgName: "UseridIcon")
        saveBtn.layer.cornerRadius = saveBtn.frame.height/2;
        saveBtn.backgroundColor = UIColor.yellow
        
     
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
//        navigationItem.setCustomTitle("Title", font: UIFont.systemFont(ofSize: 16, weight: UIFont.Weight.medium), textColor: .white)
//
//        navigationItem.set
    
     
        navigationController?.navigationBar.topItem?.title = "Profile"
    }
    
    
    
    
    @IBAction func SaveBtnClicked(_ sender: Any) {
        
        
        
    }
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
