//
//  AppUtility.swift
//  TreeClimbr2
//
//  Created by Mar Koss on 2020-03-20.
//  Copyright © 2020 Mar Koss. All rights reserved.
//

import Foundation
import UIKit

struct AppUtility
{
    
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask)
    {
        
        if let delegate = UIApplication.shared.delegate as? AppDelegate
        {
            delegate.orientationLock = orientation
        }
    }
    
    /// OPTIONAL Added method to adjust lock and rotate to the desired orientation
    static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation)
    {
        self.lockOrientation(orientation)
        
        UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
    }
    
}
