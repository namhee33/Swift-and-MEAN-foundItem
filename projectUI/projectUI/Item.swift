//
//  Item.swift
//  projectUI
//
//  Created by Sarah Sherman on 1/26/16.
//  Copyright © 2016 Sarah Sherman. All rights reserved.
//

import Foundation

<<<<<<< HEAD
class Item {
    var name: String
    var latitude: Double
    var longitude: Double
    var distance: Int
    var zipCode: Int
    var details: String
    var dateListed: String
    var found: Int
    init(name: String, latitude: Double, longitude: Double, distance: Int, zipCode: Int, details: String, dateListed: String, found: Int) {
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.distance = distance
        self.zipCode = zipCode
        self.details = details
        self.dateListed = dateListed
        self.found = found
    }
}
=======

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
>>>>>>> e61c26e3881f3599101a354c6a649be9c5090792
