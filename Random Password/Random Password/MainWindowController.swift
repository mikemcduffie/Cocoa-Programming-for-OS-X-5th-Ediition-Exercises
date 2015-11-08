//
//  MainWindowController.swift
//  Random Password
//
//  Created by Mike McDuffie on 11/1/15.
//  Copyright © 2015 M2. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    
    @IBOutlet weak var textField: NSTextField!


    override var windowNibName: String? {
        
        return "MainWindowController"
        
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        print ("window loaded from Nib named \(windowNibName)")
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
        
        // @IBAction func generatePassword(sender: AnyObject) {
        
    }

    @IBAction func generatePassword(sender: AnyObject) {
        
        // Tell the text field what to display
        
        // Get a random string of length 8
        
        let length = 16
        
        let password = generateRandomString(length)
        
        textField.stringValue = password
    }
    
    deinit {
        print ("\(self) will be deallocated")
    }
    
}
