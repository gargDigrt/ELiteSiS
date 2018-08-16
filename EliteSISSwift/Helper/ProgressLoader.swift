//
//  ProgressLoader.swift
//  EliteSISSwift
//
//  Created by Vivek on 12/08/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import Foundation
import ALLoadingView

class ProgressLoader {
    
    static var shared = ProgressLoader()
    
    func showLoader(withText text:String){
        
        // https://www.cocoacontrols.com/controls/alloadingview
        
        ALLoadingView.manager.resetToDefaults()
        ALLoadingView.manager.blurredBackground = true
        ALLoadingView.manager.animationDuration = 1.0
        ALLoadingView.manager.itemSpacing = 30.0
        ALLoadingView.manager.messageText = text
        ALLoadingView.manager.showLoadingView(ofType: .messageWithIndicator, windowMode: .fullscreen)
        
    }
    
    func hideLoader(){
        
        ALLoadingView.manager.hideLoadingView(withDelay: 0.0)
        ALLoadingView.manager.resetToDefaults()
        
    }
    
}
