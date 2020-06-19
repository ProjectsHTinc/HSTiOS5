//
//  Login.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 15/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class Login: UIViewController,UITextFieldDelegate, LoginView {
        
    @IBOutlet var mobileNumber: UITextField!
    @IBOutlet var selectedConstituency: UITextField!
    @IBOutlet var activityView: UIActivityIndicatorView!
    
    /*Get Login Otp*/
    let presenter = LoginPresenter(loginService: LoginService())
    var From = String()
        
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*set delegate for Textfields*/
        self.mobileNumber.delegate = self
        /*Tap anywhere to hide keypad*/
        self.hideKeyboardWhenTappedAround()
        /*Get selected Constituency Name*/
        if From == "selected"
        {
            self.selectedConstituency.text = GlobalVariables.shared.selectedConstituencyName
            selectedConstituency.attributedPlaceholder = NSAttributedString(string: "Select Constituency",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }
        else
        {
            /*Set placeholder color For Textfield*/
            selectedConstituency.attributedPlaceholder = NSAttributedString(string: "Select Constituency",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.black])
        }
        /*Hide Activity View*/
        activityView.hidesWhenStopped = true
        
    }
        
    @IBAction func loginAction(_ sender: Any)
    {
        guard CheckValuesAreEmpty () else {
            return
        }
        
        self.requestToOtp()
    }
    
    @IBAction func constituencyListAction(_ sender: Any)
    {
        guard Reachability.isConnectedToNetwork() == true else {
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return
        }
        
        self.selectedConstituency.text = ""
        Navigator.onMoveToConstituencyList(view: self)
    }
    
    func CheckValuesAreEmpty () -> Bool{
        
        guard Reachability.isConnectedToNetwork() == true else{
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
             return false
        }
        
        guard self.selectedConstituency.text?.count != 0  else {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: Globals.ConstituencyAlertMessage, complition: {
                
              })
             return false
         }
        
        guard self.mobileNumber.text?.count != 0  else {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: Globals.LoginAlertMessage, complition: {
                
              })
             return false
         }
        
          return true
    }
    
    func setPeople(appversion: [AppVersion])
    {
         
    }
    
    func requestToOtp()
    {
        presenter.attachView(view: self)
        presenter.getOtp(mobile_no: mobileNumber.text!.replacingOccurrences(of: " ", with: ""))
    }
    
    func startLoading()
    {
        /*Hide Activity View*/
        activityView.isHidden = true
        activityView.startAnimating()
    }
    
    func finishLoading()
    {
         activityView.isHidden = false
         activityView.stopAnimating()
    }
    
     func setLoginOtp(login_otp: String) {
        let mobile_otp = login_otp
        self.performSegue(withIdentifier: "to_OTP", sender: mobile_otp)
     }
     
     func setEmptyLogin(errorMessage: String) {
          AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
          })
     }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let length = self.getTextLength(mobileNo: self.mobileNumber.text!)
         if length == 10{
            if range.length == 0{
                return false
            }
         }
        
         if length == 5{
            let num : String = self.formatNumber(mobileNo: self.mobileNumber.text!)

            textField.text = num + " "
            if(range.length > 0){
                textField.text = (num as NSString).substring(to: 5)
            }
         }
         else if length == 5{

            let num : String = self.formatNumber(mobileNo: self.mobileNumber.text!)

            let prefix  = (num as NSString).substring(to: 5)
            let postfix = (num as NSString).substring(from: 5)

            textField.text = prefix + " " + postfix + " "

            if range.length > 0{
                textField.text = prefix + postfix
            }
        }

        return true
    }

    func getTextLength(mobileNo: String) -> NSInteger{

         var str : NSString = mobileNo as NSString
         str = str.replacingOccurrences(of: "(", with: "") as NSString as NSString
         str = str.replacingOccurrences(of: ")", with: "") as NSString
         str = str.replacingOccurrences(of: " ", with: "") as NSString
         str = str.replacingOccurrences(of: "-", with: "") as NSString
         str = str.replacingOccurrences(of: "+", with: "") as NSString

            return str.length
    }
    
    func formatNumber(mobileNo: String) -> String{
        
         var str : NSString = mobileNo as NSString
         str = str.replacingOccurrences(of: "(", with: "") as NSString
         str = str.replacingOccurrences(of: ")", with: "") as NSString
         str = str.replacingOccurrences(of: " ", with: "") as NSString
         str = str.replacingOccurrences(of: "-", with: "") as NSString
         str = str.replacingOccurrences(of: "+", with: "") as NSString

        if str.length > 10{
           str = str.substring(from: str.length - 10) as NSString
        }

        return str as String
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_OTP"){
           let nav = segue.destination as! UINavigationController
           let vc = nav.topViewController as! OTP
           vc.otp = sender as! String
           vc.mobileNumber = self.mobileNumber.text!.replacingOccurrences(of: " ", with: "") 
        }
    }
    

}


