//
//  Defaults_Font.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/23/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

extension Defaults {
    
    class func navigationFont() -> UIFont {
        return UIFont.init(name: Defaults.Font.iowanBold.rawValue, size: 20)!
    }
    
    class func font(_ font: Font, size: CGFloat) -> UIFont {
        let fontIdentifier: String = font.rawValue
        return UIFont.init(name: fontIdentifier, size: size)!
    }
    
    
    class func allFonts() {
        let families = UIFont.familyNames
        for name in families {
            print(name)
        }
    }

    enum Font: String {
        case iowanBold = "IowanOldStyleBT-Bold"
        case iowanRoman = "IowanOldStyleBT-Roman"
    }
}
