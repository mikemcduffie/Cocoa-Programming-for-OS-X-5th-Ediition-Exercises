//
//  CarArrayController.swift
//  CarLot
//
//  Created by Mike McDuffie on 11/23/15.
//  Copyright © 2015 M2. All rights reserved.
//

import Cocoa

class CarArrayController: NSArrayController {
    
    override func newObject() -> AnyObject {
        let newObj = super.newObject() as! NSObject
        let now = NSDate()
        newObj.setValue(now, forKey:"datePurchased")
        return newObj
    }

}
