//
//  RoundedImage.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/21/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

@IBDesignable class RoundedImage: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height/2
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = #colorLiteral(red: 0.5999328494, green: 0.6000387073, blue: 0.5999261737, alpha: 1)
    }
}
