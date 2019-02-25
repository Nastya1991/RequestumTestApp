//
//  ViewControllerExtension.swift
//  TestAppKeyToTech
//
//  Created by Nastya on 2/5/19.
//  Copyright © 2019 Nastya. All rights reserved.
//

import UIKit

extension UIViewController
{
    class func controllerFromStoryboard(controllerClass:AnyClass, from storyboard:String) -> UIViewController
    {
        let identController = "\(controllerClass)"
        return self.controllerFromStoryboard(controllerName:identController, from:storyboard)
    }
    
    class func controllerFromStoryboard(controllerName:String, from storyboardName:String) -> UIViewController
    {
        let storyboard = UIStoryboard.init(name: storyboardName, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: controllerName)
    }
    
    func resignAllFields(view:UIView?=nil)
    {
        var container = view
        if container == nil {
            container = self.view
        }
        for item in container!.subviews {
            if item is UITextField {
                item.resignFirstResponder()
            } else {
                self.resignAllFields(view:item)
            }
        }
    }
}
