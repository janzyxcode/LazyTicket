//
//  MainViewController.swift
//  Ticket
//
//  Created by liaonaigang on 2018/1/9.
//  Copyright © 2018年 ngliao. All rights reserved.
//

import Cocoa

class MainViewController: NSViewController {
    
    @IBOutlet weak var tableView: NSTableView!
    fileprivate var ticketLeftList = [[String: String]]()
    @IBOutlet weak var captchaImgv: NSImageView!
    var captchaSelectList = Array(repeating: false, count: 8)
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settupViews()
        
        timer = Timer(timeInterval: 0.5, target: self, selector: #selector(runForInfo), userInfo: nil, repeats: true)
        RunLoop.main.add(timer, forMode: .commonModes)
    }
    
    private func settupViews(){
        tableView.usesAlternatingRowBackgroundColors = true
        tableView.selectionHighlightStyle = .none
    }
    
    @objc func runForInfo(){
        getTicketLeftJson()
        getCapthaImage()
    }
    
    @IBAction func testAction(_ sender: Any) {
        let noti = NSUserNotification()
        noti.title = "Test Title"
        noti.informativeText = "hello world"
        noti.hasActionButton = true
        noti.soundName = NSUserNotificationDefaultSoundName
        NSUserNotificationCenter.default.deliver(noti)
        NSUserNotificationCenter.default.delegate = self
        print("send noti")
    }
    
    @IBAction func captchaActionSelect(_ sender: NSButton) {

        sender.isContinuous = !sender.isContinuous
        sender.title = sender.isContinuous == true ? "1" : "0"
        
        let attr = NSMutableAttributedString(attributedString: sender.attributedTitle)
        attr.addAttributes([NSAttributedStringKey.font: NSFont.boldSystemFont(ofSize: 30),NSAttributedStringKey.foregroundColor: NSColor.red], range: NSMakeRange(0, sender.title.count))
        sender.attributedTitle = attr

        captchaSelectList[sender.tag] = sender.state.rawValue == 0 ? false : true
    }
    
    @IBAction func loginAction(_ sender: Any) {
        var str = ""
        for item in captchaSelectList.enumerated() {
            if item.element {
                let row = item.offset % 4
                let section = item.offset / 4
                let rowValue = 35 + 70 * row
                let sectionValue = section * 70 + 35
                str += "\(rowValue),\(sectionValue),"
            }
        }
        
        if str.count > 0{
            str.removeLast()
        }else{
            return
        }
        
        let url = "/Users/user/Desktop/LazyTicket/Ticket Python/cons/config.json"
        let mgr = FileManager.default
        if mgr.fileExists(atPath: url) {
            guard let content = FileManager.default.contents(atPath: url) else{
                return
            }
            do {
                let list = try JSONSerialization.jsonObject(with: content, options: .mutableLeaves)
                guard var dict = list as? [String: Any] else{
                    return
                }
                dict["capthaPoistions"] = str
                
                
//                dict["capthaPoistions"] = ""
//                dict["authUamtk"] = ""
                let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                if let dataStr = NSString(data: data, encoding: String.Encoding.utf8.rawValue){
                    try dataStr.write(toFile: url, atomically: false, encoding: String.Encoding.utf8.rawValue)
                }
            }catch{
                print(error.localizedDescription)
            }
        }

        
        print(str)
    }
}

extension MainViewController{
    // Now close App Sandbox can read file content, beacause i don't want to publish to mac app store.
    // https://www.jianshu.com/p/842896e5de10
    // http://www.skyfox.org/cocoa-macos-sandbox.html
    func getTicketLeftJson(){
        let url = "/Users/user/Desktop/LazyTicket/Ticket Python/tickets/ticketLeft.json"
        let mgr = FileManager.default
        if mgr.fileExists(atPath: url) {
            guard let content = FileManager.default.contents(atPath: url) else{
                return
            }
            do {
                let list = try JSONSerialization.jsonObject(with: content, options: .mutableLeaves)
                guard let dictList = list as? [[String: String]] else{
                    return
                }
                self.ticketLeftList = dictList
                self.tableView.reloadData()
            }catch{
                print(error.localizedDescription)
            }
        }
    }
    
    func getCapthaImage(){
        let url = "/Users/user/Desktop/LazyTicket/Ticket Python/captchaImage/catchpaImage.png"
        captchaImgv.image = NSImage(contentsOfFile: url)
    }
}

extension MainViewController:NSUserNotificationCenterDelegate{
    func userNotificationCenter(_ center: NSUserNotificationCenter, shouldPresent notification: NSUserNotification) -> Bool {
        return true
    }
    func userNotificationCenter(_ center: NSUserNotificationCenter, didActivate notification: NSUserNotification) {
        print("====")
    }
}

extension MainViewController:NSTableViewDelegate,NSTableViewDataSource{
    func numberOfRows(in tableView: NSTableView) -> Int {
        return ticketLeftList.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        var cellV = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "Cell"), owner: self) as? NSTextField

        if cellV == nil {
            cellV = NSTextField()
            cellV?.alignment = .center
            cellV?.isEditable = false
            cellV?.isBordered = false
            cellV?.isBezeled = false
            cellV?.drawsBackground = false
            cellV?.identifier = NSUserInterfaceItemIdentifier(rawValue: "Cell")
        }
        
        if let cellTitle = tableColumn?.title{
            let dict = ticketLeftList[row]
            cellV?.stringValue = dict[cellTitle] ?? ""
        }
        return cellV
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 30
    }
}
