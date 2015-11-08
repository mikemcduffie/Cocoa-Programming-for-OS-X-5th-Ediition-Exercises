//
//  GeneratePassword.swift
//  Random Password
//
//  Created by Mike McDuffie on 11/1/15.
//  Copyright © 2015 M2. All rights reserved.
//

import Foundation

private let characters = Array(("01234567890abcdefghijklmnopqrstuvwxyz" + "ABCDEFGHIJKLMNOPQRSTUVWXYZ").characters)

func generateRandomString(length: Int) -> String {
    // Start with an empty string
    
    var string = ""
    
    // Append 'length' number of random characters
    
    // Xcode 7 warns about the for loop in generateRandomString(_:), since the index var is not used. You can silence this warning by using an "_" in place of the unused variable
    
    for _ in 0..<length {
        
        string.append(generateRandomCharacter())
    }
    
    return string
}

func generateRandomCharacter() -> Character {
    
    // Create a random index into the characters array
    
    let index = Int(arc4random_uniform(UInt32(characters.count)))
    
//    let character = characters[index]
    
    return characters[index]

}
