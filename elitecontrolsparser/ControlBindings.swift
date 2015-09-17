//
//  ControlBindings.swift
//  EliteCopilot
//
//  Created by Frank Nichols on 9/16/15.
//  Copyright © 2015 Frank Nichols. All rights reserved.
//

import Cocoa

class ControlBindings: NSObject, NSXMLParserDelegate {

    var prevName: String = "none"
    var cmdArray  = [Command]()
    var activeCommandsOnly: Bool = false
    
    func ImportControlBindings(controlBindingPath: String, activeCommandsOnly: Bool) {
        
        cmdArray = []
        
        let xmlParser = NSXMLParser(data: NSData(contentsOfFile: controlBindingPath)!)
        self.activeCommandsOnly = activeCommandsOnly
        
        xmlParser.delegate = self
        let err = xmlParser.parse()
        if err != true {
            print("Error Parsing")
        } else {
            print("Parsing Successful")
        }
    }
    
    func parser(parser: NSXMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String]) {
        
        let cmd = prevName
        let type = elementName
        var device: String = ""
        var aKey: String = ""
        
        switch elementName {
        case "Primary":
             if let key = attributeDict["Key"] {
                aKey = key
                if let aDevice = attributeDict["Device"] {
                    device = aDevice
                }
            }
            if aKey == ""
            {
                aKey = "{NoKey}"
            }
            let aCmd = Command(command: cmd, type: type, key: aKey, device: device)
            if activeCommandsOnly == false {
                cmdArray.append(aCmd)
            } else if aKey.containsString("Key_") == true {
                cmdArray.append(aCmd)
            }
            
        default:
            prevName = elementName
            break
        }
    }
}
