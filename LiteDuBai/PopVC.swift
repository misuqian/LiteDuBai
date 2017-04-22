//
//  PopVC.swift
//  SafariTest
//
//  Created by 彭芊 on 2017/4/22.
//  Copyright © 2017年 彭芊. All rights reserved.
//

import Cocoa
import SafariServices

class PopVC: SFSafariExtensionViewController {
    @IBOutlet weak var guanggao: NSButton!
    @IBOutlet weak var youbianlan: NSButton!
    @IBOutlet weak var yun: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(!UserDefaults.standard.bool(forKey: "firstin")){
            UserDefaults.standard.set(true, forKey: "guanggao")
            UserDefaults.standard.set(true, forKey: "youbian")
            UserDefaults.standard.set(true, forKey: "yun")
            UserDefaults.standard.set(true, forKey: "firstin")
        }
        guanggao.state = UserDefaults.standard.bool(forKey: "guanggao") ? 1 : 0
        youbianlan.state = UserDefaults.standard.bool(forKey: "youbian") ? 1 : 0
        yun.state = UserDefaults.standard.bool(forKey: "yun") ? 1 : 0
    }
    
    @IBAction func guanggaoTap(_ sender: NSButton) {
        UserDefaults.standard.set(sender.state == 1, forKey: "guanggao")
    }
    
    @IBAction func youbianlanTap(_ sender: NSButton) {
        UserDefaults.standard.set(sender.state == 1, forKey: "youbian")
    }
    
    @IBAction func yunDownloadTAp(_ sender: NSButton) {
        UserDefaults.standard.set(sender.state == 1, forKey: "yun")
    }
    
}
