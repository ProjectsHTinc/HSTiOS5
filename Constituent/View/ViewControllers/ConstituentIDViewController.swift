//
//  ConstituentIDViewController.swift
//  Constituent
//
//  Created by HappysanziMac on 02/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

//to_OTP

import UIKit

class ConstituentIDViewController: UIViewController,ConstiuentIdView {
    
    @IBOutlet weak var constituentIdTextField: UITextField!
    @IBOutlet weak var getStartedOutlet: UIButton!
    
    let presenter = ConstiuentIdPresenter(constiuentIdService: ConstiuentIdService())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func getStartedAction(_ sender: Any) {
        
        self.requestToOtp()
    }
    
    func requestToOtp()
    {
        DispatchQueue.main.async {
            // Run UI Updates or call completion block
            self.presenter.attachView(view: self)
            self.presenter.getOtp(constituency_code: self.constituentIdTextField.text!)
        }
    }
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    func setLoginOtp(dynamic_db: String) {
        
        self.performSegue(withIdentifier: "to_Login", sender: self)
        print("constituent\(dynamic_db)")
        GlobalVariables.shared.dynamic_Db = dynamic_db
        print("constituent\(GlobalVariables.shared.dynamic_Db)")
    }
    
    func setEmptyLogin(errorMessage: String) {
        
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_Login")
        {
            let _ = segue.destination as! Login
        }
    }
}
