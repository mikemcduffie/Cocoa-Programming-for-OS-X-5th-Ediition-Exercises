//
//  MainWindowController.swift
//  DataSource-ToDoListApp
//
//  Created by Mike McDuffie on 11/6/15.
//  Copyright © 2015 M2. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSTableViewDataSource, NSTableViewDelegate, NSControlTextEditingDelegate {
    
    @IBOutlet weak var addButton: NSButton!
    @IBOutlet weak var enterItemField: NSTextField!
    @IBOutlet weak var tableView: NSTableView!
    
    var toDoList: [String] = []  // Array of strings initialized as empty/nil
    
    override var windowNibName: String {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        addButton.enabled = false
        enterItemField.stringValue = ""
        
        
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    @IBAction func textEnter(sender: AnyObject) {
        if enterItemField.stringValue != "" {
            addItem(self)
        }
    }
    
    @IBAction func addItem(sender: AnyObject) {
        toDoList.append(enterItemField.stringValue)
        print("\(toDoList)")
        tableView.reloadData()

        addButton.enabled = false
        enterItemField.stringValue  = ""
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return toDoList.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let item = toDoList[row]
        return item
    }
    
    // MARK: - NSTableViewDelegate
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let row = tableView.selectedRow
        print ("Selected row = \(row)")
        if row == -1 {
            print("No item selected")
            return
        }
       
        let item = toDoList[row]
    }
    
    
     // MARK: - NSControlTextEditingDelegate
    

    override func controlTextDidChange(obj: NSNotification) {
        print("texfield = \(enterItemField.stringValue)")

        if enterItemField.stringValue != "" {
            addButton.enabled = true
        }
        else {
            addButton.enabled = false
        }
//        super.controlTextDidChange(obj) //not needed -- double types

    }
}
