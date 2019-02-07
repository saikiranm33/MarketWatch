//
//  Orders+CoreDataProperties.swift
//  MarketWatch
//
//  Created by NUNC on 2/6/19.
//  Copyright © 2019 NUNC. All rights reserved.
//
//

import Foundation
import CoreData


extension Orders {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Orders> {
        return NSFetchRequest<Orders>(entityName: "Orders")
    }

    @NSManaged public var name: String?
    @NSManaged public var orderType: String?
    @NSManaged public var price: String?
    @NSManaged public var exchange: String?
    @NSManaged public var quantity: String?

}
