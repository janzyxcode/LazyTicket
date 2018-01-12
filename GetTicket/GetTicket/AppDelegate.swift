//
//  AppDelegate.swift
//  GetTicket
//
//  Created by liaonaigang on 2018/1/10.
//  Copyright © 2018年 ngliao. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet var window: NSWindow!
    
    
    var statusBtn:NSStatusItem?
    var popover:NSPopover?

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        print("===")
        settupviews()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
        print("-=-=")
    }
}



