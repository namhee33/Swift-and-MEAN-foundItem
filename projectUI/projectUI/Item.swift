//
//  Item.swift
//  projectUI
//
//  Created by Sarah Sherman on 1/26/16.
//  Copyright © 2016 Sarah Sherman. All rights reserved.
//

import Foundation



class Item {
    var iid: String
    var userName: String
    var location: String
    var itemName: String
    var detail: String
    var locationY: Double
    var locationX: Double
    var imageUrl: String
    var createdAt: String
    var founds: [NSDictionary]
    
    init(iid: String, userName: String, itemName: String, locationX: Double, locationY: Double, details: String, dateListed: String, imageUrl: String, location: String) {
        self.iid = iid
        self.userName = userName
        self.itemName = itemName
        self.location = location
        self.locationX = locationX
        self.locationY = locationY
        self.imageUrl = imageUrl
        self.detail = details
        self.createdAt = dateListed
        self.founds = [NSDictionary]()
    }}
