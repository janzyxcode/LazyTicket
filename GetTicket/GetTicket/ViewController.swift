//
//  ViewController.swift
//  GetTicket
//
//  Created by liaonaigang on 2018/1/10.
//  Copyright © 2018年 ngliao. All rights reserved.
//

import Cocoa


class ViewController: NSViewController {

    var statusBtn:NSStatusItem?
    var popover:NSPopover?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settupviews()
    }
    
}

extension ViewController{
    func settupviews(){
        popover = NSPopover()
        popover?.behavior = .transient
        popover?.appearance = NSAppearance(named:NSAppearance.Name.vibrantLight)
        popover?.contentViewController = MainViewController(nibName: NSNib.Name(rawValue: "MainViewController"), bundle: nil)
        
        statusBtn = NSStatusBar.system.statusItem(withLength: 30)
        let image = NSImage(named: NSImage.Name(rawValue: "statusbar_ico"))
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

