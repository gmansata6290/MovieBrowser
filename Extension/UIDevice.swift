//
//  UIDevice.swift
//  MovieBrowser
//
//  Created by Shayona on 28/12/18.
//  Copyright © 2018 Shayona. All rights reserved.
//

import UIKit

extension UIDevice {
    
    var iPhoneX: Bool {
        return UIScreen.main.nativeBounds.height == 2436
    }
    
    var iPhone: Bool {
        return UIDevice.current.userInterfaceIdiom == .phone
    }
    
    var iPad: Bool {
        return UIDevice.current.userInterfaceIdiom == .pad
    }
    
    enum ScreenType: String {
        case iPhones_4_4S = "iPhone 4 or iPhone 4S"
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6P_6sP_7P_8P = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_XS = "iPhone X or iPhone XS"
        case iPhone_XR = "iPhone XR"
        case iPhone_XSMax = "iPhone XS Max"
        case iPad = "iPad 1, iPad 2, iPad Mini 1"
        case iPadRetina = "iPad 3, iPad 4, iPad 5, iPad Air 1, iPad Air 2, iPad Mini 2, iPad Mini 3, iPad Mini 4, iPad Pro 9.7"
        case iPadPro10_5 = "iPad Pro 10.5"
        case iPadPro12_9 = "iPad Pro 12.9 2nd Gen"
        case unknown
    }
    
    var screenType: ScreenType {
        
        switch UIScreen.main.nativeBounds.height {
        case 960:
            return .iPhones_4_4S
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1792:
            return .iPhone_XR
        case 1920, 2208:
            return .iPhones_6P_6sP_7P_8P
        case 2436:
            return .iPhones_X_XS
        case 2688:
            return .iPhone_XSMax
        case 1024:
            //Checking Device Pixel Ratio
            return UIScreen.main.scale == 1 ?  .iPad : .iPadRetina
        case 1112:
            return .iPadPro10_5
        case 1366:
            return .iPadPro12_9
        default:
            return .unknown
        }
    }
}
