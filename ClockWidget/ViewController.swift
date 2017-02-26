//
//  ViewController.swift
//  ClockWidget
//
//  Created by 박현기 on 2017. 2. 26..
//  Copyright © 2017년 박현기. All rights reserved.
//

import Cocoa
import IOKit.ps

class ViewController: NSViewController {
    
    @IBOutlet weak var time: NSTextField!
    @IBOutlet weak var battery: NSTextField!
    @IBOutlet weak var customTextView: NSTextField!
    
    var timer : Timer?
    var format : DateFormatter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.layer?.backgroundColor = NSColor.clear.cgColor
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.setTimer), userInfo: nil, repeats: true)
        
        format = DateFormatter()
        format?.dateFormat = "HH mm"
        
        setTimer()
    }
    
    func getBattery() -> [String]
    {
        let task = Process()
        let pipe = Pipe()
        task.launchPath = "/usr/bin/pmset"
        task.arguments = ["-g", "batt"]
        task.standardOutput = pipe
        task.launch()
        
        let data = pipe.fileHandleForReading.readDataToEndOfFile()
        let output = NSString(data: data, encoding: String.Encoding.utf8.rawValue) as! String
        
        let batteryArray = output.components(separatedBy: ";")
        let source = output.components(separatedBy: "'")[1]
        let state = batteryArray[1].trimmingCharacters(in: NSCharacterSet.whitespaces).capitalized
        let percent = String.init(batteryArray[0].components(separatedBy: ")")[1].trimmingCharacters(in: NSCharacterSet.whitespaces).characters.dropLast())
        var remaining = String.init(batteryArray[2].characters.dropFirst().split(separator: " ")[0])
        if(remaining == "(no"){
            remaining = "Calculating"
        }
        
        return [source, state, percent, remaining]
    }
    
    func setTimer() {
        
        let delegate = NSApplication.shared().delegate as! AppDelegate
        
        customTextView.stringValue = delegate.string
        
        if (NSColor(hexString: delegate.color) == nil) {
            
            customTextView.textColor = NSColor.white
            
        } else {
            
            let color: NSColor = NSColor(hexString: delegate.color)!
            customTextView.textColor = color
        }
        
        if (getBattery()[1] == "Charged") {
            self.battery.textColor = NSColor(hexString: "88da6f")!
        } else {
            if (Int(getBattery()[2])! <= 50) {
                self.battery.textColor = NSColor(hexString: "ffe04d")!
            } else if (Int(getBattery()[2])! <= 10) {
                self.battery.textColor = NSColor(hexString: "ff4d4d")!
            } else {
                self.battery.textColor = NSColor.white
            }
        }
        
        battery.stringValue = "\(getBattery()[0])   |   \(getBattery()[1])   |   \(getBattery()[2])%   |  \(getBattery()[3])"
        
        if let dateString = format?.string(from: Date()) {
            time.stringValue = dateString
        }
    }
    
    override var representedObject: Any? {
        didSet {
            
        }
    }

}

public extension NSColor {
    public class func hexColor(rgbValue: Int, alpha: CGFloat = 1.0) -> NSColor {
        return NSColor(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16))/255.0, green:((CGFloat)((rgbValue & 0xFF00) >> 8))/255.0, blue:((CGFloat)(rgbValue & 0xFF))/255.0, alpha:alpha)
    }
    
}

