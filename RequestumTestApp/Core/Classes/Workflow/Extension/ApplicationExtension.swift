//
//  ApplicationExtension.swift
//  RequestumTestApp
//
//  Created by Nastya on 2/24/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

extension UIApplication {
    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navController = controller as? UINavigationController {
            return topViewController(controller: navController.visibleViewController)
        }
        return controller
    }
}
