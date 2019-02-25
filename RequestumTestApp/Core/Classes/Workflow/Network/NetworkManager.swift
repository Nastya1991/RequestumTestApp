//
//  NetworkManager.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit
import Alamofire

typealias HttpData       = Dictionary<String, AnyObject>
typealias SuccessClosure = (_ sender:NetworkManager?, _ response:AnyObject) -> ()
typealias FailureClosure = (_ error:ErrorExtension?) -> ()

class NetworkManager : NSObject {
    
    static let sharedInstance = NetworkManager()
    let baseURL                 = Defaults.Constants.BaseUrl.rawValue
    var method                  = "GET"
    var shortEndpoint           = ""
    var data:HttpData           = ["":"" as AnyObject]
    var parameters:HttpData!
    
    var cache:NetworkCache?
    var cacheAvailable:Bool     = true
    var success:SuccessClosure!
    var fail:FailureClosure!
    var request:URLRequest?
    
    var response                = NSDictionary()
    var responseHeaders         = [AnyHashable:Any]()
    var status                  = NetworkStatus.error
    var statusCode              = 0
    var error:ErrorExtension?            = nil
    
    lazy var endpointPath : String = {
        return self.fullEndpoint(endpoint: self.shortEndpoint)
    }()
    
    lazy var urlRequest : URLRequest = {
        let url = URL(string: self.endpointPath)!
        let request: NSMutableURLRequest = NSMutableURLRequest(url:url)
        request.httpMethod = self.method
        self.addParams(request: request)
        return request as URLRequest
    }()
    
    func request(_ method:String, _ parameters:Dictionary<String, AnyObject>, _ endpoint:String, _ success:@escaping SuccessClosure, _ fail:@escaping FailureClosure, _ cacheAvailable:Bool) {
        

        self.method         = method
        self.shortEndpoint  = endpoint
        self.data           = parameters
        self.cacheAvailable = cacheAvailable
        self.parameters     = parameters
        self.success        = success
        self.fail           = fail
        self.status         = .ok
        
        if !self.extractFromCache() {
            self.requestFromNetwork()
        }
    }
    
    func requestFromNetwork() {
        self.networkSends()
        let request = self.urlRequest
        
        Alamofire.request(request)
            .responseJSON { success in
                print(">>> Answer from remote server: \(self.shortEndpoint)")
                
                guard let response = success.response else {
                    print("RESPONSE CAN'T BE TO PARSE")
                    self.status = .error
                    self.networkResponse()
                    self.handle()
                    return
                }
                
               
                self.statusCode      = response.statusCode
                self.status          = NetworkStatus(rawValue: self.statusCode) ?? NetworkStatus.error
                self.response        = success.result.value as? NSDictionary ?? NSDictionary()
                self.error           = success.result.error as? ErrorExtension
                self.request         = success.request
                self.responseHeaders = response.allHeaderFields
                self.handle()
                self.networkResponse()
        }
    }
    
    // MARK: - Virtual
    func saveToCache() { }
    func extractFromCache() -> Bool {
        return false
    }
    func networkSends()     { }
    func networkResponse()  { }
    
    // MARK: - Private
    private func fullEndpoint(endpoint:String) -> String {
        return self.baseURL + endpoint
    }
    
    private func addParams(request: NSMutableURLRequest?=nil) {
        guard let request = request,
            let dict = self.parameters  else {
                return
        }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: dict, options:[])
        } catch {
            print("JSON serialization failed:  \(error)")
        }
    }    
}
