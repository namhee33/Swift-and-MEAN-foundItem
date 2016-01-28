//
//  Found.swift
//  projectUI
//
//  Created by namhee kim on 1/27/16.
//  Copyright © 2016 Sarah Sherman. All rights reserved.
//

import Foundation


class Found {
    
    var storeName: String
    var price: Double
    var detail: String
    var foundDate: NSDate
    var locationX: Double
    var locationY: Double
    
    init(storeName: String, price: Double, detail: String, foundDate: NSDate, locationX: Double, locationY: Double) {
        self.storeName = storeName
        self.price = price
        self.detail = detail
        
        self.foundDate = foundDate
        self.locationX = locationX
        self.locationY = locationY
        
    }
}