//
//  ProgressLoader.swift
//  EliteSISSwift
//
//  Created by Vivek on 12/08/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import Foundation
import MBProgressHUD

class ProgressLoader {
    
    static var shared = ProgressLoader()
    
    func showLoader(withText text:String){
        
        let window = UIApplication.shared.windows.last
        let hud = MBProgressHUD.showAdded(to: window!, animated: true)
        hud.label.text = text
        
    }
    
    func hideLoader(){
        let window = UIApplication.shared.windows.last
        MBProgressHUD.hide(for: window!, animated: true)
    }

}
