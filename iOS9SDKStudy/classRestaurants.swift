//
//  classRestaurants.swift
//  FirstTV
//
//  Created by Александр on 27.06.16.
//  Copyright © 2016 Александр. All rights reserved.
//

import Foundation

class Restaurant {
    var Name = ""
    var `Type` = ""
    var Location = ""
    var Image = ""
    var IsVisited = false
    var phoneNumber = ""
    
    init(name: String, type: String, location: String, phoneNumber: String, image: String, isVisited: Bool) {
        self.Name = name
        self.Type = type
        self.Location = location
        self.Image = image
        self.IsVisited = isVisited
        self.phoneNumber = phoneNumber
    }
}
