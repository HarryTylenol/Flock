//
//  AppDelegate.swift
//  ClockWidget
//
//  Created by 박현기 on 2017. 2. 26..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var string : String = "Simple clock app made by Tylenol"
    var color : String = "ffffff"
    let popover = NSPopover()
    let statusItem = NSStatusBar.system().statusItem(withLength: -2)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named: "ic_watch_later_white_18pt")
            button.action = #selector(togglePopover(sender:))
        }
        
        popover.contentViewController = PoverViewController(nibName: "PoverViewController", bundle: nil)
        
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func showPopover(sender: AnyObject?) {
        if let button = statusItem.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
        }
    }
    
    func closePopover(sender: AnyObject?) {
        popover.performClose(sender)
    }
    
    func togglePopover(sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender: sender)
        } else {
            showPopover(sender: sender)
        }
    }
}
