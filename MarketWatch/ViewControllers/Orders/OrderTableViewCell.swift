//
//  OrderTableViewCell.swift
//  MarketWatch
//
//  Created by NUNC on 2/6/19.
//  Copyright © 2019 NUNC. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    
    
    
    
    
    
    @IBOutlet var orderView: UIView!
    @IBOutlet var stockName: UILabel!
    @IBOutlet var pricelbl: UILabel!
    @IBOutlet var ordeTypeLbl: UILabel!
    @IBOutlet var ExcnageLbl: UILabel!
    @IBOutlet var quantitylbl: UILabel!
    
    
    @IBOutlet weak var priceValueLbl: UILabel!
    
    @IBOutlet weak var quantityValueLbl: UILabel!
    
    @IBOutlet weak var orderValueLbl: UILabel!
    
    @IBOutlet weak var exchangeValueLbl: UILabel!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
       orderView.clipsToBounds = true
        orderView.layer.cornerRadius = 10
        stockName.font = UIFont.init(name:AppSubHeadingFont , size: 18);
        
        
        pricelbl.font = UIFont.init(name:AppSubHeadingFont , size: 16);
        ExcnageLbl.font = UIFont.init(name:AppSubHeadingFont , size: 16);
        quantitylbl.font = UIFont.init(name:AppSubHeadingFont , size: 16);
        ordeTypeLbl.font = UIFont.init(name:AppSubHeadingFont , size: 16);
        
    
        priceValueLbl.font = UIFont.init(name:AppLightTextFont , size: 15);
        quantityValueLbl.font = UIFont.init(name:AppLightTextFont , size: 15);
        orderValueLbl.font = UIFont.init(name:AppLightTextFont , size: 15);
        exchangeValueLbl.font = UIFont.init(name:AppLightTextFont , size: 15);
        
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
