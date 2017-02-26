//
//  PoverViewController.swift
//  ClockWidget
//
//  Created by 박현기 on 2017. 2. 26..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Cocoa

class PoverViewController: NSViewController {
    
    @IBOutlet weak var customText: NSTextField!
    @IBOutlet weak var customColor: NSTextField!
    let appDelegate = NSApplication.shared().delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customText.stringValue = appDelegate.string
        customColor.stringValue = appDelegate.color
    }
    
    @IBAction func applyButton(_ sender: Any) {
        appDelegate.string = customText.stringValue
        appDelegate.color = customColor.stringValue
    }
}
