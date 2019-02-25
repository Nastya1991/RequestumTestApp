//
//  Network_LoadImage.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit
import Alamofire

typealias LoadImageSuccessed = (_ image:UIImage) -> ()

extension NetworkManager {
    
    class func image(link:String, success:@escaping SuccessClosure, fail:@escaping FailureClosure) {
        
        let path = self.filenameByLink(link: link)

        let cachedImage = self.loadImageFromStorage(filePath: path)
        
        if cachedImage != nil  {
            success(nil, cachedImage!)
        } else {
            self.loadImageFromNetwork(link: link, success: success, fail: fail)
        }
    }
    
    
    class func loadImageFromNetwork(link:String, success:@escaping SuccessClosure, fail:@escaping FailureClosure) {
        guard link.filled, let url = URL(string: link)  else {
            return
        }
        
        if url.absoluteString.lenght == 0 {
            let error = NSError(domain: "Link can't be url", code: -1, userInfo: ["link":link])
            fail(error as? ErrorExtension)
            return
        }
        
        let queryCharacterSet = NSCharacterSet.urlQueryAllowed
        guard let escapedLink = link.addingPercentEncoding(withAllowedCharacters: queryCharacterSet) else {
            return
        }
        
        Alamofire.request(escapedLink, method: .get)
            .validate()
            .responseData(completionHandler: { (response) in
                
                guard let responseData = response.data else {
                    return fail(response.result.error as? ErrorExtension)
                }
                let image = UIImage(data: responseData)
                success(nil, image!)
                self.saveImageToStorage(image: image!, link: link)
            })
    }
    
    // MARK: - Private
    private class func loadImageFromStorage(filePath:String) -> UIImage? {
        let image = UIImage(contentsOfFile: filePath)
        return image
    }
    
    private class func saveImageToStorage(image:UIImage, link:String) {
        let filepath = self.filenameByLink(link: link)
        self.saveImageToStorageWithPath(image: image, path: filepath)
    }
    
    
    private class func saveImageToStorageWithPath(image:UIImage, path:String) {
        let storage           = FileStorage()
        let fileManager       = FileManager.default
        let imageData = image.jpegData(compressionQuality: 0.0)
        do {
            try fileManager.createDirectory(atPath: storage.cachesPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            
        }
        fileManager.createFile(atPath: path, contents: imageData, attributes: nil)
        
    }
    
    private class func filenameByLink(link:String) -> String {
        let filename = "\(link.hash).jpg"
        let storage  = FileStorage()
        return "\(storage.cachesPath)/\(filename)"
    }

}
