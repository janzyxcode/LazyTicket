//
//  AppDelegate.swift
//  SpringTicket
//
//  Created by  user on 2018/1/12.
//  Copyright © 2018年 NG. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!
    var statusBtn:NSStatusItem?
    var popover:NSPopover?
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        settupviews()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}


extension AppDelegate{
    func settupviews(){
        popover = NSPopover()
        popover?.behavior = .transient
        popover?.appearance = NSAppearance(named:NSAppearance.Name.vibrantLight)
        popover?.contentViewController = MainViewController(nibName: NSNib.Name(rawValue: "MainViewController"), bundle: nil)
        
        statusBtn = NSStatusBar.system.statusItem(withLength: 30)
        let image = NSImage(named: NSImage.Name(rawValue: "train_ico"))
        image?.isTemplate = true
        statusBtn?.image = image
        statusBtn?.highlightMode = true
        statusBtn?.target = self
        statusBtn?.action = #selector(statusBtnAction(_:))
    }
    
    @objc func statusBtnAction(_ sender:NSView){
        popover?.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY)
    }
}
