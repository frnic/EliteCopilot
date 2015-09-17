//
//  Command.swift
//EliteCopilot
//
//  Created by Frank Nichols on 9/15/15.
//  Copyright © 2015 Frank Nichols. All rights reserved.
//

import Cocoa
@objc(Command)
class Command: NSObject {
    
    var command: String = ""    // text of command, this is what you say to trigger this command
    var type: String = ""       // the primary or secondary definition for the activating key
    var key: String = ""        // the key to be pressed
    var keyDown: Bool = true    // keyDown - if false, then do not press the key before releasing - used where on command presses it and another releases it.
    var keyPressTime = 1.0      // the duration of the keydown in seconds, 0.0 means unlimited (another command releases the key.)
    var keyUp: Bool = true
    var ctlKey: Bool = false
    var commandKey: Bool = false
    var altKey: Bool = false
    var shiftKey: Bool = false
    var device: String = ""
    
    override init() {
        command = "Hello World"
        type = "Primary"
        device = "Keyboard"
        key = "Key_?"
        
        super.init()
    }
    
    init(command: String, type: String, key: String, device: String) {
        self.command = command
        self.type = type
        self.key = key
        self.device = device

        super.init()
    }
}
