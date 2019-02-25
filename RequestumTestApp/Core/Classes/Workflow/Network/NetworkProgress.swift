//
//  NetworkProgress.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/24/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit
import MBProgressHUD

class NetworkProgress: NSObject, NetworkProgressProtocol, MBProgressHUDDelegate {
    
    var decorator:NetworkProgressProtocol?
    static let sharedInstance = NetworkProgress()

    private var hud:MBProgressHUD?
    private var activeRequestsCounter = 0
    private override init() {
        super.init()
    }
    
    class func sharedInstanceWithDecorator(decorator:NetworkProgressProtocol) -> NetworkProgressProtocol {
        self.sharedInstance.decorator = decorator
        return self.sharedInstance
    }

    class func show() {
        self.sharedInstance.indicateSendingRequest()
    }
    
    class func hide(){
        self.sharedInstance.indicateReceiveResponse()
    }

    internal func indicateSendingRequest(){
        if let _ = self.decorator {
            self.decorator?.indicateSendingRequest()
        }
        
        DispatchQueue.main.async {
                self.activeRequestsCounter += 1
                print("Indicator is \(self.activeRequestsCounter)")
                if self.activeRequestsCounter == 1 {
                    self.showLoader()
                }
        }
    }
    
    internal func indicateReceiveResponse(){
        if let _ = self.decorator {
            self.decorator?.indicateReceiveResponse()
        }
        
        DispatchQueue.main.async{
                self.activeRequestsCounter -= 1
                print("Indicator is \(self.activeRequestsCounter)")
                if self.activeRequestsCounter < 1 {
                    self.hideLoader()
                }
        }
    }
    
    private func showLoader(){
        DispatchQueue.main.async {
            let currentView    = self.lastView()
            self.hud           = MBProgressHUD.showAdded(to: currentView, animated: true)
        }
    }
    
    
    private func hideLoader(){
        DispatchQueue.main.async{
                if let hud = self.hud {
                    hud.hide(animated: true)
                    self.hud = nil
                    self.activeRequestsCounter = 0
                }
        }
    }
    
    private func lastView() -> UIView{
        return UIApplication.shared.keyWindow!.subviews.last!
    }
    
}
