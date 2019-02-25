//
//  SearchBarExtension.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/24/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

extension UISearchBar {
    
    var textField: UITextField? {
        return value(forKey: "searchField") as? UITextField
        
    }
    
    var placeholderLabel: UILabel? {
        return textField?.value(forKey: "placeholderLabel") as? UILabel
    }
    
    var icon: UIImageView? {
        return textField?.leftView as? UIImageView
    }
    var iconColor: UIColor? {
        get {
            return icon?.tintColor
        }
        set {
            icon?.image = icon?.image?.withRenderingMode(.alwaysTemplate)
            icon?.tintColor = newValue
        }
    }
}
