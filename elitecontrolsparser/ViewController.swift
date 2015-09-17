//
//  ViewController.swift
//EliteCopilot
//
//  Created by Frank Nichols on 9/15/15.
//  Copyright © 2015 Frank Nichols. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSSpeechSynthesizerDelegate, NSSpeechRecognizerDelegate {
    
    func delay(delay:Double, closure:()->()) {
        
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    override func viewDidLoad() {
        
        let path = "/Users/frank/Library/Application Support/Frontier Developments/Elite Dangerous/Options/Bindings/Custom.binds"
        
        controlBindingPath.stringValue = path
        
        speechSynth.delegate = self
        
        super.viewDidLoad()
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    // MARK: === In Game Control Bindings ===
    
    var controlBindings = ControlBindings()
    var activeCommandsOnly = false
    
    @IBOutlet var cmdArrayController: NSArrayController!
    
    @IBOutlet weak var controlBindingPath: NSTextField!
    
    @IBAction func allCommands(sender: AnyObject) {
        activeCommandsOnly = false
        importControlSet()
    }
    
    @IBAction func activeOnly(sender: AnyObject) {
        activeCommandsOnly = true
        importControlSet()
    }
    
    @IBAction func addCommand(sender: NSButton) {
        
        let aCmd = Command()
        cmdArrayController.insertObject(aCmd, atArrangedObjectIndex: 0)
    }
    
    @IBAction func importControls(sender: NSButton) {
        activeCommandsOnly = true
        importControlSet ()
    }
    
    func importControlSet () {
    
        controlBindings.ImportControlBindings(controlBindingPath.stringValue, activeCommandsOnly: activeCommandsOnly)
        
        //
        // the following add/remove is a MAJOR HACK. Apparently Google doesn't know how
        // to fix this problem. The problem is that my cmdArrayController is not auto
        // populating as I load up the cmdArray from the XML control settings file. It
        // has been reported a couple times, but I could find no explanations on what
        // I am doing wrong to cause this. So, I hacked this for now, this is just a
        // proof of concept and so, I don't really care - this hack will not be in the
        // final code.
        //
        // This bascically just casues an add followed by a delete
        // which causes the cmdArrayController to refresh itself from the data source.
        //
        // --frnic 15.09.2015
        //
        let aCmd = Command(command: "void", type: "void", key: "void", device: "void")
        cmdArrayController.insertObject(aCmd, atArrangedObjectIndex: 0)
        cmdArrayController.removeObjectAtArrangedObjectIndex(0)
    }
    
    func getCurrentCommands() -> [Command]
    {
        var cmdList = [Command]()
        
        for aCmd in cmdArrayController.arrangedObjects as! [Command] {
            cmdList.append(aCmd)
        }
        return cmdList
    }
    
    // MARK: === Speech Synthesizer ===
    
    let speechSynth = NSSpeechSynthesizer()
    
    // MARK: === Speech Recognizer ===
    
    
    let speechRecognizer = NSSpeechRecognizer()!
    var cmdList = [Command]()
    var keyCode = 0x01
    
    @IBAction func startListening(sender: AnyObject) {
        
        cmdList = getCurrentCommands()
        var voiceCommands = [String]()
        for aCmd in cmdList {
            if aCmd.key.containsString("Key_") == true
            {
                voiceCommands.append(aCmd.command)
            }
        }
        
        speechRecognizer.startListening()
        
        speechRecognizer.delegate = self
        speechRecognizer.commands = voiceCommands
        speechRecognizer.listensInForegroundOnly = false
        speechRecognizer.blocksOtherRecognizers = true
        
        print("listening")
    }
    
    @IBAction func stopListening(sender: AnyObject) {
        
        speechRecognizer.stopListening()
        print("not listening")
    }
    
    var foundCmd = Command()
    let src: CGEventSource = CGEventSourceCreate(CGEventSourceStateID.CombinedSessionState)!
    
    func speechRecognizer(sender: NSSpeechRecognizer, didRecognizeCommand command: String) {
        
        print("Command: \(command)")
        speechSynth.startSpeakingString("Yes commander! \(command)")
        
        for aCmd in cmdList {
             if aCmd.command == command {
                foundCmd = aCmd
                cmdArrayController.setSelectedObjects([foundCmd])
                break
            }
       }
        
        if let aKeyCode = keyCodes[foundCmd.key] {
            
            print ("keyCode: \(foundCmd.key) = [\(aKeyCode)]")
            
            let pressKey = CGEventCreateKeyboardEvent(src, aKeyCode, true)
            let unPressKey = CGEventCreateKeyboardEvent(src, aKeyCode, false)
            
            if foundCmd.keyDown == true {
                CGEventPost(CGEventTapLocation.CGHIDEventTap, pressKey)
            }
            
            if foundCmd.keyUp == true {
                delay(foundCmd.keyPressTime) {
                    CGEventPost(CGEventTapLocation.CGHIDEventTap, unPressKey)
                }
            } else if foundCmd.keyPressTime > 0.0 {
                delay(foundCmd.keyPressTime) {
                    CGEventPost(CGEventTapLocation.CGHIDEventTap, unPressKey)
                }
            }
        }
    }
}
