//
//  TabbarController.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class TabbarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Set select tabbar index*/
        self.selectedIndex = 1

        /*Tabbar border width*/
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBar.clipsToBounds = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
