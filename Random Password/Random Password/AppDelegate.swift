//
//  AppDelegate.swift
//  Random Password
//
//  Created by Mike McDuffie on 11/1/15.
//  Copyright © 2015 M2. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    var mainWindowController: MainWindowController?


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application

        // Create a window controller with a XIB file of the same name
        // let mainWindowController = MainWindowController(windowNibName: "MainWindowController")
        let mainWindowController = MainWindowController()

        // Put the window of the window controller on screen
        
        mainWindowController.showWindow(self)
        
        // Set the property to point to the window
        
        self.mainWindowController = mainWindowController
        
        }
    

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }


}





