//
//  GetStartedScreen.swift
//  Constituent
//
//  Created by HappysanziMac on 28/05/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class GetStartedScreen: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func getStartedAction(_ sender: Any) {
        
        UserDefaults.standard.setValue("yes", forKey: "getStartedKey")
        self.performSegue(withIdentifier: "Login", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "Login"){
            _ = segue.destination as! ConstituentIDViewController
         }
    }
}
