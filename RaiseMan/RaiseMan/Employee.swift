//
//  Employee.swift
//  RaiseMan
//
//  Created by Mike McDuffie on 11/15/15.
//  Copyright © 2015 M2. All rights reserved.
//

import Foundation

class Employee: NSObject, NSCoding {
    var name: String? = "New Employee"
    var raise: Float = 0.05
    

    // MARK: - NSCoding
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObjectForKey("name") as! String?
        raise = aDecoder.decodeFloatForKey("raise")
        super.init()
    }
    
    override init() {
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        if let name = name {
            aCoder.encodeObject(name, forKey: "name")
        }
        aCoder.encodeFloat(raise, forKey: "raise")
    }


    
//    func validateRaise (raiseNumberPointer: AutoreleasingUnsafeMutablePointer<NSNumber?>, error outError: NSErrorPointer) -> Bool {
//        let raiseNumber = raiseNumberPointer.memory
//        if raiseNumber == nil {
//            let domain = "UserInputValidationErrorDomain"
//            let code = 0
//            let userInfo = [NSLocalizedDescriptionKey : "An employee's raise must be a number."]
//            outError.memory = NSError(domain: domain, code: code, userInfo: userInfo)
//            return false
//        } else {
//            return true
//        }
//    }
    
    // Swift 2.0 throw style:

    func validateRaise(raiseNumberPointer:
        AutoreleasingUnsafeMutablePointer<NSNumber?>) throws {
            let raiseNumber = raiseNumberPointer.memory
            if raiseNumber == nil {
                let domain = "UserInputValidationErrorDomain"
                let code = 0
                let userInfo = [NSLocalizedDescriptionKey : "An employee's raise must be a number."]
                throw NSError(domain: domain, code: code, userInfo: userInfo)
            }
    }
    
}