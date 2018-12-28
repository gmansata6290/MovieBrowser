//
//  UIFont.swift
//  MovieBrowser
//
//  Created by Shayona on 28/12/18.
//  Copyright © 2018 Shayona. All rights reserved.
//

import UIKit

extension UIFont {
    
    class func appFont(withsize size : CGFloat) -> UIFont {
        
        guard let font = UIFont(name: "HelveticaNeue-Medium", size: size)
            else
        {
            return UIFont()
        }
        
        return font
    }
}
