//
//  AppSettings.swift
//  Constituent
//
//  Created by HappysanziMac on 31/05/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class AppSettings: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.view.isHidden = false
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
    @IBAction func logoutAction(_ sender: Any) {
        
        self.clearAllData ()
    }
    
    func clearAllData ()
    {
        // Create the alert controller
        let alertController = UIAlertController(title: Globals.alertTitle, message: "Are you sure want to sign out", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            NSLog("OK Pressed")
            UserDefaults.standard.clearUserData()
//            self.performSegue(withIdentifier: "to_SignOut", sender: self)
            self.reNew()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @IBAction func changeUser(_ sender: Any) {
         
        self.performSegue(withIdentifier: "to_ConstituencyList", sender: self)
    }
    
    func reNew() {
            //reload application data (renew root view )
        UIApplication.shared.keyWindow?.rootViewController = storyboard!.instantiateViewController(withIdentifier: "getStart")
        }
}
