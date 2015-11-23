//
//  Document.swift
//  RaiseMan
//
//  Created by Mike McDuffie on 11/15/15.
//  Copyright © 2015 M2. All rights reserved.
//

import Cocoa

private var KVOContext: Int = 0

class Document: NSDocument, NSWindowDelegate {
    
    @IBOutlet weak var tableView: NSTableView!
    @IBOutlet var arrayController: NSArrayController!
    
    var employees: [Employee] = [] {
        willSet {
            for employee in employees {
                stopObservingEmployee(employee)
            }
        }
        didSet {
            for employee in employees {
                startObservingEmployee(employee)
            }
        }
    }
    
    override init() {
        super.init()
        // Add your subclass-specific initialization here.
    }
    
    override func windowControllerDidLoadNib(aController: NSWindowController) {
        super.windowControllerDidLoadNib(aController)
        // Add any code here that needs to be executed once the windowController has loaded the document's window.
    }
    
    override class func autosavesInPlace() -> Bool {
        return true
    }
    
    override var windowNibName: String? {
        // Returns the nib file name of the document
        // If you need to use a subclass of NSWindowController or if your document supports multiple NSWindowControllers, you should remove this property and override -makeWindowControllers instead.
        return "Document"
    }
    
    override func dataOfType(typeName: String) throws -> NSData {
        tableView.window!.endEditingFor(nil)
        return NSKeyedArchiver.archivedDataWithRootObject(employees)
    }
    
    override func readFromData(data: NSData, ofType typeName: String) throws {
        print ("About to read data of type \(typeName).")
        employees = NSKeyedUnarchiver.unarchiveObjectWithData(data) as! [Employee]
    }
    
    
    // MARK: - Accessors
    
    func insertObject(employee: Employee, inEmployeesAtIndex index: Int) {
        print("adding \(employee) to the employess array")
        
        // Add the inverse of this operation to the undo stack
        let undo: NSUndoManager = undoManager!
        undo.prepareWithInvocationTarget(self).removeObjectFromEmployeesAtIndex(employees.count)
        if !undo.undoing {
            undo.setActionName("Add Employee")
        }
        
        employees.append(employee)
    }
    
    func removeObjectFromEmployeesAtIndex(index: Int) {
        let employee: Employee = employees[index]
        
        print("removing \(employee) from the employees array")
        
        // Add the inverse of this operation to the undo stack
        let undo: NSUndoManager = undoManager!
        undo.prepareWithInvocationTarget(self).insertObject(employee, inEmployeesAtIndex: index)
        if !undo.undoing {
            undo.setActionName("Remove Employee")
        }
        
        // Remove the Employee from the array
        employees.removeAtIndex(index)
    }
    
    // MARK: - Key Value Observing
    
    func startObservingEmployee(employee: Employee) {
        employee.addObserver(self, forKeyPath: "name", options: .Old, context: &KVOContext)
        employee.addObserver(self, forKeyPath: "raise", options: .Old, context: &KVOContext)
    }
    
    func stopObservingEmployee(employee: Employee) {
        employee.removeObserver(self, forKeyPath: "name", context: &KVOContext)
        employee.removeObserver(self, forKeyPath: "raise", context: &KVOContext)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        if let keyPath = keyPath, object = object, change = change {
            if context != &KVOContext {
                // If the context does match, this message must be intended for the superclass.
                super.observeValueForKeyPath(keyPath, ofObject: object, change: change, context: context)
                var oldValue: AnyObject? = change[NSKeyValueChangeOldKey]
                if oldValue is NSNull {
                    oldValue = nil
                }
                
                let undo: NSUndoManager = undoManager!
                print("oldValue=\(oldValue)")
                undo.prepareWithInvocationTarget(object).setValue(oldValue, forKeyPath: keyPath)
                return
            }
        }
    }
    
    // MARK: - NSWindowDelegate
    
    func windowWillClose(notification: NSNotification) {
        employees = []
    }
    
    // MARK: - Actions
    
    @IBAction func addEmployee(sender: NSButton) {
        let windowController = windowControllers[0] as NSWindowController
        let window = windowController.window!
        
        let endedEditing = window.makeFirstResponder(window)
        if !endedEditing {
            print ("Unable to endEditing.")
            return
        }
        
        let undo: NSUndoManager = undoManager!
        
        // Has edit occured already in this event?
        
        if undo.groupingLevel > 0 {
            //Close the last group
            undo.endUndoGrouping()
            // open a new group
            undo.beginUndoGrouping()
        }
        
        // Create the object
        let employee = arrayController.newObject() as! Employee
        
        // Add it to the array controller's contentArray
        arrayController.addObject(employee)
        
        // Re-sort (in case the user has sorted a column)
        arrayController.rearrangeObjects()
        
        // Get the sorted array
        let sortedEmployees = arrayController.arrangedObjects as! [Employee]
        
        // Find the object just added
        let row = sortedEmployees.indexOf(employee)!
        
        // Begin the edit in the first column
        print ("starting edit of \(employee) in row \(row)")
        tableView.editColumn(0,
            row: row,
            withEvent: nil,
            select: true)
    }
    
    
}





