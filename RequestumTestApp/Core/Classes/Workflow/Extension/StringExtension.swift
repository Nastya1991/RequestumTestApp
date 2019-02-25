//
//  StringExtension.swift
//  TestAppKeyToTech
//
//  Created by Nastya on 2/6/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

extension String {
    
    var trim:String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
    
    var filled : Bool {
        return self.trim.lenght > 0
    }
    
    var lenght:Int {
        get {
            return self.count
        }
    }
    
    var removingNewlines: String {
        return String(self.filter { !"\n\t\r".contains($0) })
    }
    
    var loc:String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    
    func heightByFont(width:CGFloat, font:UIFont = UIFont.systemFont(ofSize: 16)) -> CGFloat
    {
        let place       = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let rect        = self.boundingRect(with: place, options: .usesLineFragmentOrigin,
                                            attributes: [NSAttributedString.Key.font:font],
                                            context: nil)
        return rect.size.height
    }
}


extension String {
    func loadImage(success:@escaping LoadImageSuccessed) {
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            NetworkManager.image(link: self, success: { (network, response) -> () in
                
                if let image = response as? UIImage {
                    success(image)
                }
                
            }) { (error) -> () in
                print(error ?? "UNKNOW ERROR FOR IMAGE LINK\n\(self)")
            }
        }
    }
}
