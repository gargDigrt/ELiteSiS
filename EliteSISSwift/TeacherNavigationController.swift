//
//  TeacherNavigationController.swift
//  EliteSISSwift
//
//  Created by Reetesh Bajpai on 30/03/18.
//  Copyright © 2018 Vivek Garg. All rights reserved.
//

import UIKit

class TeacherNavigationController: ENSideMenuNavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sideMenu = ENSideMenu(sourceView: self.view, menuViewController: MyMenuTableViewController(), menuPosition:.left)
        //sideMenu?.delegate = self //optional
        
        sideMenu?.menuWidth = 300 // optional, default is 160
        //sideMenu?.bouncingEnabled = false
        //sideMenu?.allowPanGesture = false
        // make navigation bar showing over side menu
        view.bringSubview(toFront: navigationBar)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension TeacherNavigationController: ENSideMenuDelegate {
    func sideMenuWillOpen() {
        print("sideMenuWillOpen")
    }
    
    func sideMenuWillClose() {
        print("sideMenuWillClose")
    }
    
    func sideMenuDidClose() {
        print("sideMenuDidClose")
    }
    
    func sideMenuDidOpen() {
        print("sideMenuDidOpen")
    }
    
    func sideMenuShouldOpenSideMenu() -> Bool {
        return true
    }
}

