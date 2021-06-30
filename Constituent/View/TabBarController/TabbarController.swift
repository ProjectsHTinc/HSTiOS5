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
        self.selectedIndex = 0

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

enum Side: String {
    case top, left, right, bottom
}

extension UIImage {
    func createSelectionIndicator(color: UIColor, size: CGSize, lineThickness: CGFloat, side: Side) -> UIImage {
        var xPosition = 0.0
        var yPosition = 0.0
        var imgWidth = 2.0
        var imgHeight = 2.0
        switch side {
            case .top:
                xPosition = 0.0
                yPosition = 0.0
                imgWidth = Double(size.width)
                imgHeight = Double(lineThickness)
            case .bottom:
                xPosition = 0.0
                yPosition = Double(size.height - lineThickness)
                imgWidth = Double(size.width)
                imgHeight = Double(lineThickness)
            case .left:
                xPosition = 0.0
                yPosition = 0.0
                imgWidth = Double(lineThickness)
                imgHeight = Double(size.height)
            case .right:
                xPosition = Double(size.width - lineThickness)
                yPosition = 0.0
                imgWidth = Double(lineThickness)
                imgHeight = Double(size.height)
        }
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(x: xPosition, y: yPosition, width: imgWidth, height: imgHeight))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
