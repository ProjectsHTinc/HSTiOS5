//
//  Navigator.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 16/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Navigator: NSObject {
    
    static func onMoveToConstituencyList(view : UIViewController){
        let vc: UIViewController? = view.storyboard?.instantiateViewController(withIdentifier: "constituencyList") as! ConstituencyList
        vc?.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        if let aVc = vc {
            view.present(aVc, animated: true, completion: nil)
        }
        else{
            print("Error")
        }
    }
    
}
