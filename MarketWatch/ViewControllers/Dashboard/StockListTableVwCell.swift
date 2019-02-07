//
//  StockListTableVwCell.swift
//  MarketWatch
//
//  Created by Nunc on 06/02/19.
//  Copyright © 2019 NUNC. All rights reserved.
//

import UIKit

class StockListTableVwCell: UITableViewCell {

    @IBOutlet weak var subView: UIView!
    
    @IBOutlet weak var nameTxt: UILabel!
    
    @IBOutlet weak var exchangeLbl: UILabel!
    
    @IBOutlet weak var exchangeValueLbl: UILabel!
    
    @IBOutlet weak var currentPriceLbl: UILabel!
    
    @IBOutlet weak var currentPriceValueLbl: UILabel!
    
    @IBOutlet weak var buyBtn: UIButton!
    
    @IBOutlet weak var sellBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        subView.clipsToBounds = true
        subView.layer.cornerRadius = 5
        nameTxt.font = UIFont.init(name:AppHeadingFont , size: 18);
        currentPriceLbl.font = UIFont.init(name:AppSubHeadingFont , size: 16);
        exchangeLbl.font = UIFont.init(name:AppSubHeadingFont , size: 16);
        exchangeValueLbl.font = UIFont.init(name:AppLightTextFont , size: 15);
        currentPriceValueLbl.font = UIFont.init(name:AppLightTextFont , size: 15);
        
        
        sellBtn.clipsToBounds = true
        buyBtn.clipsToBounds = true
        
        sellBtn.layer.cornerRadius = 5
        buyBtn.layer.cornerRadius = 5
        
    
       
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
