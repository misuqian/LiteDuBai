//
//  SafariExtensionHandler.swift
//  LiteDuBai
//
//  Created by 彭芊 on 2017/4/21.
//  Copyright © 2017年 彭芊. All rights reserved.
//

import SafariServices

class SafariExtensionHandler: SFSafariExtensionHandler {
    
    override func messageReceived(withName messageName: String, from page: SFSafariPage, userInfo: [String : Any]?) {
        // This method will be called when a content script provided by your extension calls safari.extension.dispatchMessage("message").
        if messageName == "GetAdsHide" {
            page.dispatchMessageToScript(withName: "adsHide", userInfo:nil);
        }
    }
    
    override func toolbarItemClicked(in window: SFSafariWindow) {
        // This method will be called when your toolbar item is clicked.
        window.getActiveTab { (activeTab) in
            activeTab?.getActivePage { (activePage) in
                activePage?.dispatchMessageToScript(withName: "fileDownload", userInfo: nil)
            }
        }
    }
    
    override func validateToolbarItem(in window: SFSafariWindow, validationHandler: @escaping ((Bool, String) -> Void)) {
        // This is called when Safari's state changed in some way that would require the extension's toolbar item to be validated again.
        validationHandler(true, "")
    }
    
//    override func popoverViewController() -> SFSafariExtensionViewController {
//        return SafariExtensionViewController.shared
//    }
//    
}
