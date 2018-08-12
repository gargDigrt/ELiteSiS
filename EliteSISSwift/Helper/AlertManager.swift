//
//  AlertManager.swift
//  EliteSISSwift
//
//  Created by Vivek on 13/08/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit


class AlertManager {
    
    var rootWindow: UIWindow!
    static var shared = AlertManager()
    
    
    func showAlertWith(title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .clear
        window.rootViewController = UIViewController()
        AlertManager.shared.rootWindow = UIApplication.shared.windows.first
        window.windowLevel = UIWindowLevelAlert
        window.makeKeyAndVisible()
        window.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
}
