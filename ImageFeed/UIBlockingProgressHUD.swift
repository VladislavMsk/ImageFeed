//
//  UIBlockingProgressHUD.swift
//  ImageFeed
//
//  Created by Vladislav Tudos on 17.06.2024.
//

import UIKit
import ProgressHUD

final class UIBlockingProgressHUD{
    private static var window: UIWindow? {
            return UIApplication.shared.windows.first
        }
    
    static func show(){
        window?.isUserInteractionEnabled = true
        ProgressHUD.animate()
    }
    static func dismiss(){
        window?.isUserInteractionEnabled = false
        ProgressHUD.dismiss()
    }

}

