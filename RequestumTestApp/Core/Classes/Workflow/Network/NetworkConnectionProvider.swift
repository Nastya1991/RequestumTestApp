//
//  NetworkConnectionProvider.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit
import Alamofire

class NetworkConnectionProvider : UIControl  {
    static var instance = NetworkConnectionProvider()
    
    typealias NetworkStatus = NetworkReachabilityManager.NetworkReachabilityStatus
    
    var lastStatus = NetworkStatus.unknown {
        didSet(value) {
            if value != self.lastStatus {
                if self.lastStatus  == .notReachable {
                    showAlert("Not Connection", "Please check your internet connection.")
                } else {
                    if value == .notReachable{
                        showAlert("Connection", "Please restart the application to reload the data",true)
                    }
                }
            }
        }
    }
    
    class func start() {
        let _ = self.instance.start()
        print("Network connection provider started")
    }
    
    private var manager:NetworkReachabilityManager!
    
    
    // MARK: - Private
    fileprivate func start() {
        let manager = NetworkReachabilityManager(host:Defaults.Constants.PingHost.rawValue)
        manager?.listener = { status in
            self.statusChanged(status)
        }
        
        manager?.startListening()
        self.manager = manager
    }
    
    private func statusChanged(_ status:NetworkStatus) {
        guard self.lastStatus != status  else {
            return
        }
        
        
        if status == .reachable(.ethernetOrWiFi) {
            print("NETWORK IS FAST")
        }
        
        if status == .reachable(.wwan) {
            print("NETWORK IS SLOW")
        }
        
        if status == .notReachable {
            print("NETWORK DOES NOT EXIST")
        }
        
        if status == .unknown {
            print("NETWORK STATUS IS UNKNOW")
        }
        
        self.lastStatus = status
    }
    
    private func showAlert(_ titleText: String,_ description:String,_ reloadData : Bool = false) {
        let alert = UIAlertController(title: titleText, message: description, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Ok", style: .default) { (action:UIAlertAction) in
            if reloadData{
                guard let vc = UIApplication.topViewController() else {
                    return
                }
                vc.viewDidLoad()
            }
        }
        alert.addAction(ok)
        UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
    }
}
