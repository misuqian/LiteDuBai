//
//  SafariExtensionHandler.swift
//  LiteDuBai
//
//  Created by 彭芊 on 2017/4/21.
//  Copyright © 2017年 彭芊. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler{
    static var popView : PopVC! = nil
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        if messageName == "GetAdsHide" {
            page.dispatchMessageToScript(withName: "adsHide", userInfo:["openRight":UserDefaults.standard.bool(forKey: "youbian"),"openAd":UserDefaults.standard.bool(forKey: "guanggao"),"openYun":UserDefaults.standard.bool(forKey: "yun")]);
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
//        window.getActiveTab { (activeTab) in
//            activeTab?.getActivePage { (activePage) in
//                activePage?.dispatchMessageToScript(withName: "fileDownload", userInfo: [])
//            }
//        }
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
    override func popoverViewController() -> SFSafariExtensionViewController {
        if(SafariExtensionHandler.popView == nil){
            let storyBoard = NSStoryboard(name: "main", bundle: nil)
            SafariExtensionHandler.popView =  storyBoard.instantiateController(withIdentifier: "pop") as! PopVC
        }
        return SafariExtensionHandler.popView
    }
}
