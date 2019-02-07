//
//  MarketWatchViewController.swift
//  MarketWatch
//
//  Created by Nunc on 06/02/19.
//  Copyright © 2019 NUNC. All rights reserved.
//

import UIKit
import Popover

class MarketWatchViewController: UIViewController {
    
    
    @IBOutlet weak var stockTableView: UITableView!
    
    
    var responseArr = NSArray()
    let popover = Popover()
    let priceTxt = UITextField()
    let quantityTxt = UITextField()
    var typeStr = NSString()
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        stockTableView.delegate = self
        stockTableView.dataSource = self
        stockTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
 
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
       
     fetchDataFromFile()
       
     navigationController?.navigationBar.isHidden = true
        
    }
   
    func fetchDataFromFile()
    {
        
        
        if let path = Bundle.main.path(forResource: "marketwatch", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                
                let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as! [String:Any]
                
                
                
                responseArr = jsonObj["stocks"] as! NSArray
                
                
                
                stockTableView.reloadData()
                
                
                
                print("jsonData:\(jsonObj)")
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
        
    
        
        
    }
    
    
}

extension MarketWatchViewController:UITableViewDataSource,UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
     
        
        return 200;
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = stockTableView.dequeueReusableCell(withIdentifier: "StockCell", for: indexPath)as! StockListTableVwCell
        
        let myResponseDict  = responseArr[indexPath.row] as! [String:Any]
        
        
        cell.nameTxt.text = String(describing: myResponseDict["name"]!)
        cell.exchangeValueLbl.text =     ":  \(myResponseDict["exchange"]!)"
        cell.currentPriceValueLbl.text = ":  \(myResponseDict["current_price"]!)"
        
        
        cell.sellBtn.addTarget(self, action: #selector(onClickItem), for: .touchUpInside)
        cell.buyBtn.addTarget(self, action: #selector(onClickItem), for: .touchUpInside)
        
        
        
        return cell
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    
    
    
    @objc func onClickItem(sender:UIButton!)
    {
        
        typeStr = sender.titleLabel!.text! as NSString
        
        
        let popUpView = UIView()
        popUpView.frame =  CGRect(x: 0, y: 0, width: self.view.frame.width - 40, height: 240)
        
        
        
        let headerLabel = UILabel()
        headerLabel.frame = CGRect(x: popUpView.frame.size.width/2 - 40, y: 10, width: 80, height: 30)
        headerLabel.text = "\(String(describing: sender.titleLabel!.text!))"
        headerLabel.textAlignment = .center
        popUpView.addSubview(headerLabel)
        
        
        
        quantityTxt.frame = CGRect(x: 20, y:headerLabel.frame.maxY + 20 , width: popUpView.frame.size.width - 40, height: 35)
        quantityTxt.placeholder = "Enter the quantity"
        quantityTxt.keyboardType = .numberPad
        Utilites.shared.bottomLineForTextFiled(txtFilled: quantityTxt)
        popUpView.addSubview(quantityTxt)
        
        
        
        
        priceTxt.frame = CGRect(x: 20, y: quantityTxt.frame.maxY + 20  , width: popUpView.frame.size.width - 40, height: 35)
        priceTxt.placeholder = "Enter the Price"
        quantityTxt.keyboardType = .decimalPad
        Utilites.shared.bottomLineForTextFiled(txtFilled: priceTxt)
        popUpView.addSubview(priceTxt)
        
        
        let confirmButton = UIButton()
        confirmButton.frame = CGRect(x: popUpView.frame.size.width/2 - 120, y: priceTxt.frame.maxY + 30  , width:240, height: 44)
        confirmButton.setTitle("Confirm", for: .normal)
        confirmButton.setTitleColor(UIColor.init(hexRGB: ButtonBgBlueColor), for: .normal)
        confirmButton.clipsToBounds = true
        confirmButton.layer.cornerRadius = confirmButton.frame.size.height/2
        confirmButton.tag = sender.tag
        confirmButton.addTarget(self, action: #selector(confirmBtnAction), for: .touchUpInside)
        
        
        popUpView.addSubview(confirmButton)
        
        
        
        var i = 0
        
        for catDic in responseArr
        {
            
            
            var myDict = catDic as! [String:Any]
            
            if(i == sender.tag)
            {
                
                priceTxt.text = "\(String(describing: myDict["current_price"]!))"
            }
            
            
            
            
            i = i + 1
            
        }

        
        popover.showAsDialog(popUpView)
        
    }
    
    
    
    
    @objc func confirmBtnAction(sender:UIButton!)
    {
        
        popover.dismiss()
        
        var i = 0
        
        for catDic in responseArr
        {
            
            var myDict = catDic as! [String:Any]
            
            if(i == sender.tag)
            {
                
                myDict["quantity"] = String(describing:quantityTxt.text!)
                myDict["orderType"] = String(describing:typeStr)
                myDict["price"] = String(describing: priceTxt.text!)
                
              
                Utilites.shared.SaveOrdersInCoreData(InputDic: myDict as NSDictionary)
                
        
                
                print(myDict)
                
            }
            
            
            
            
            i = i + 1
            
        }
        
        
        quantityTxt.text = ""
        
        
        
    }
    
    
    
    
}
