//
//  MainWindowController.swift
//  AspectRatio
//
//  Created by Mike McDuffie on 11/5/15.
//  Copyright © 2015 M2. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSWindowDelegate {

    override var windowNibName: String {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    // MARK: - NSWindowDelegate methids
    
    func windowWillResize(sender: NSWindow, toSize frameSize: NSSize) -> NSSize {
        var newFrameSize: NSSize = NSSize() // must be initialized to assign an individual memeber of the struct
        
//        print("\(frameSize)")
        newFrameSize.height = frameSize.height
        newFrameSize.width = frameSize.height * 2
        
        return newFrameSize
    }
    
}
