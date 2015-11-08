//
//  MainWindowController.swift
//  SpeakLine
//
//  Created by Mike McDuffie on 11/5/15.
//  Copyright © 2015 M2. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate, NSWindowDelegate, NSTableViewDataSource, NSTableViewDelegate {
    
    @IBOutlet weak var speakText: NSTextField!
    @IBOutlet weak var speakButton: NSButton!
    @IBOutlet weak var stopButton: NSButton!
    @IBOutlet weak var tableView: NSTableView!
    
    let speechSynth = NSSpeechSynthesizer()
    let voices = NSSpeechSynthesizer.availableVoices() //array of strings containing dot-format voice names
    
    var isSpeaking = false {
        didSet {
            updateButtons()
        }
    }
    
    override var windowNibName: String {
        return "MainWindowController"
    }

    override func windowDidLoad() {
        super.windowDidLoad()
        updateButtons()
        speechSynth.delegate = self
        for voice in voices {
            print("\(voice)")
            print(voiceNameForIdentifier(voice)!)
        }
        let defaultVoice = NSSpeechSynthesizer.defaultVoice()
        print("\(defaultVoice)")
        if let defaultRow = voices.indexOf(defaultVoice) {
            print("\(defaultRow)")
            let indices = NSIndexSet(index: defaultRow)
            tableView.selectRowIndexes(indices, byExtendingSelection: false)
            tableView.scrollRowToVisible(defaultRow)
        }

        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }
    
    // MARK: - Action Methods
    
    @IBAction func textEnter(sender: AnyObject) {
        speak()
    }
    
    @IBAction func speakIt(sender: NSButton) {
        speak()
    }
    
    @IBAction func stopIt(sender: NSButton) {
//        isSpeaking = false  // Not needed as speechSynthesizer delegate (didFinishSPeaking method) set isSpeaking to false
        speechSynth.stopSpeaking()
    }
    
     func speak() {
        // Get typed-in tect as a string
        let textToSpeak = speakText.stringValue
        if textToSpeak.isEmpty {
            print("string from \(textToSpeak) is empty.")
        }
        else {
            isSpeaking = true
            speechSynth.startSpeakingString(textToSpeak)
        }
    }

    
    func updateButtons() {
        if isSpeaking {
            speakButton.enabled = false
            stopButton.enabled = true
        }
        else {
            stopButton.enabled = false
            speakButton.enabled = true
        }
    }
    
    func voiceNameForIdentifier(voice: String) -> String? {
        let attributes = NSSpeechSynthesizer.attributesForVoice(voice)
        return attributes[NSVoiceName] as? String
        
    }
    
    // MARK: - NSSpeechSynthesizerDelegate
    
    func speechSynthesizer(sender: NSSpeechSynthesizer, didFinishSpeaking finishedSpeaking: Bool) {
        isSpeaking = false
    }
    
    // MARK: - NSWindowDelegate
    
    func windowShouldClose(sender: AnyObject) -> Bool {
        return !isSpeaking
    }
    
    // MARK: - NSTableViewDataSource
    
    func numberOfRowsInTableView(tableView: NSTableView) -> Int {
        return voices.count
    }
    
    func tableView(tableView: NSTableView, objectValueForTableColumn tableColumn: NSTableColumn?, row: Int) -> AnyObject? {
        let voice = voices[row]
        let voiceName = voiceNameForIdentifier(voice)
        return voiceName
    }
    
    // MARK: - NSTableViewDelegate
    
    func tableViewSelectionDidChange(notification: NSNotification) {
        let row = tableView.selectedRow
        
        // Set the voice back to the default if the user has deselected all rows
        if row == -1 {
            speechSynth.setVoice(nil)
            return
        }
        let voice = voices[row]
        speechSynth.setVoice(voice)
    }
    
}

