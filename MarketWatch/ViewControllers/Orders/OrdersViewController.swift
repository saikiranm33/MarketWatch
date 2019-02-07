//
//  OrdersViewController.swift
//  MarketWatch
//
//  Created by NUNC on 2/6/19.
//  Copyright © 2019 NUNC. All rights reserved.
//

import UIKit
import CoreData
class OrdersViewController: UIViewController {
   var orderArray = NSMutableArray ()
    
    @IBOutlet var noordersLbl: UILabel!
    
    @IBOutlet var ordertablevView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        ordertablevView?.delegate = self
        ordertablevView?.dataSource = self
        ordertablevView.separatorStyle = UITableViewCell.SeparatorStyle.none
        ordertablevView.showsVerticalScrollIndicator = false
    
       // navigationController?.title = "Order"
        
       
       

    }
    override func viewWillAppear(_ animated: Bool)
    {
        
        super.viewWillAppear(animated)
        
         navigationController?.navigationBar.topItem?.title = "Order"
        orderArray  = Utilites.shared.FetchOrdersFromCoreData()
        
 
        
         print(orderArray);
        
        if (orderArray.count > 0) {
            ordertablevView.isHidden = false
            noordersLbl.isHidden = true
            
        }else{
            noordersLbl.isHidden = false
            ordertablevView.isHidden = true
            
        }
        
       ordertablevView.reloadData()
      
    }
       
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */


    extension OrdersViewController:UITableViewDataSource,UITableViewDelegate{
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          
                return orderArray.count
            
        }
        
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 180;
        }
        
        
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = ordertablevView.dequeueReusableCell(withIdentifier: "orderCell", for: indexPath)as! OrderTableViewCell
            cell.selectionStyle = .none
           let myResponseDict =  orderArray[indexPath.row] as! NSDictionary
            let rupee = "\u{20B9}"
        
            cell.stockName.text  =        "\(myResponseDict["name"]!)"
            cell.quantityValueLbl.text =  ":  \(rupee)\( myResponseDict["quantity"]!)"
            cell.orderValueLbl.text =     ":  \(myResponseDict["orderType"]!)"
            cell.priceValueLbl.text =     ":  \(myResponseDict["price"]!)"
            cell.exchangeValueLbl.text =  ":  \(myResponseDict["exchange"]!)"
            
            
            return cell
            
        }
        
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath as IndexPath, animated: true)
            
        
        }

        
    }




