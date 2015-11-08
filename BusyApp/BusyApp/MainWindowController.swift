//
//  MainWindowController.swift
//  BusyApp
//
//  Created by Mike McDuffie on 11/5/15.
//  Copyright © 2015 M2. All rights reserved.
//

import Cocoa



class MainWindowController: NSWindowController, NSSpeechSynthesizerDelegate {
    
    var sliderLastValue = 0.0
    let speechSynth = NSSpeechSynthesizer()
    var numberOfPushes = 0
    
    @IBOutlet weak var slider: NSSlider!
    @IBOutlet weak var resetControlsPressed: NSButton!
    @IBOutlet weak var showSliderTicks: NSButton!
    @IBOutlet weak var hideSliderTicks: NSButton!
    @IBOutlet weak var checkButton: NSButton!
    @IBOutlet weak var secretMessage: NSSecureTextField!
    @IBOutlet weak var revealedMessage: NSTextField!
    @IBOutlet weak var revealMessage: NSButton!
    @IBOutlet weak var sliderLabel: NSTextField!
    
    override var windowNibName: String? {
        return "MainWindowController"
    }
    
    override func windowDidLoad() {
        super.windowDidLoad()
        resetControls()
    }
    
    @IBAction func revealMessage(sender: AnyObject) {
        revealedMessage.stringValue = secretMessage.stringValue
    }
    
    @IBAction func toggleTickMarks(sender: AnyObject?) {
        if slider.numberOfTickMarks == 11 {
            slider.numberOfTickMarks = 0
        } else {
            slider.numberOfTickMarks = 11
        }
    }
    
    @IBAction func adjustSlider(sender: NSSlider) {
        //        print("slider =  \(slider.integerValue)")
        if slider.doubleValue > sliderLastValue {
            sliderLabel.stringValue = "Slider is going up!"
        } else if slider.doubleValue < sliderLastValue {
            sliderLabel.stringValue = "Slider is going down!"
        } else { // slider is unchanged
            sliderLabel.stringValue = "Slider is still!"
        }
        sliderLastValue = slider.doubleValue
    }
    
    
    @IBAction func resetControlsPressed(sender: AnyObject) {
        resetControls()
    }
    
    func resetControls() {
        secretMessage.stringValue = ""
        revealedMessage.stringValue = ""
        checkButton.state = 0
        slider.numberOfTickMarks = 11
        showSliderTicks.state = 1
        sliderLabel.stringValue = "Slider is still!"
        slider.doubleValue = 0.0
        numberOfPushes = 0
    }
    
    @IBAction func pushMe(sender: AnyObject) {
        switch numberOfPushes {
        case 0:
            speechSynth.startSpeakingString("Don't do that!")
        case 1:
            speechSynth.startSpeakingString("I told you not to do that!")
        case 2:
            speechSynth.startSpeakingString("This is starting to get irritating!")
        case 3:
            speechSynth.startSpeakingString("I bet you were a rotten child!")
        case 4:
            speechSynth.startSpeakingString("I'm not going to play this game any longer!")
        case 12:
            speechSynth.startSpeakingString("What part of No do you not understand?")
        case 13:
            let sound = NSSound(named: "Atomic_Bomb")
            sound?.play()
        case 14:
            speechSynth.startSpeakingString("He's dead Jim!")
        default:
            speechSynth.startSpeakingString("")
        }
        numberOfPushes++
        
    }
    
}