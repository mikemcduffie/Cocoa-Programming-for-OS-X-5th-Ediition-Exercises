//
//  MainWindowController.swift
//  DataSource-ToDoListApp
//
//  Created by Mike McDuffie on 11/6/15.
//  Copyright © 2015 M2. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
    
    dynamic var temperature = 68 // KVC/KVO var
    var isOn = true

    override var windowNibName: String {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func warmerClicked(sender: AnyObject) {
        if temperature < 100 {
            temperature++
        }
    }
    
    
    @IBAction func colderClicked(sender: AnyObject) {
        if temperature > 0 {
            temperature--
        }
    }
    
}
