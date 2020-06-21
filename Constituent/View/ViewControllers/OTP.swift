//
//  OTP.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 18/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class OTP: UIViewController,UITextFieldDelegate,LoginView {

    var otp = String()
    var mobileNumber = String()
    
    @IBOutlet var activityView: UIActivityIndicatorView!
    @IBOutlet var textfiledOne: UITextField!
    @IBOutlet var textfieldTwo: UITextField!
    @IBOutlet var textfieldThree: UITextField!
    @IBOutlet var textfieldfour: UITextField!
    
    /*Get Resend Otp*/
    let presenterLoginService = LoginPresenter(loginService: LoginService())
    let presenterOtpService = OTPPresenter(oTPService: OTPService())
    var otpData = [OtpData]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        /*Set Navigation Back Button*/
        self.addCustomizedBackBtn(title:"OTP")
        /*Set Delegates*/
        self.setTextfieldDelegates()
        self.textfiledOne.delegate = self
        self.textfieldTwo.delegate = self
        self.textfieldThree.delegate = self
        self.textfieldfour.delegate = self
        /*Set Functions*/
        self.setfuncForTextfiled ()
        /*Hide Activity View*/
        activityView.hidesWhenStopped = true
        

    }
    
    func setTextfieldDelegates ()
    {
        /*Set Delegates*/
        self.textfiledOne.delegate = self
        self.textfieldTwo.delegate = self
        self.textfieldThree.delegate = self
        self.textfieldfour.delegate = self
    }
    
    func setfuncForTextfiled ()
    {
        textfiledOne.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textfieldTwo.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textfieldThree.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
        textfieldfour.addTarget(self, action: #selector(self.textFieldDidChange(textField:)), for: UIControl.Event.editingChanged)
    }
    
    @objc public override func backButtonClick()
    {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func textFieldDidChange(textField: UITextField){

        let text = textField.text
        if (text?.utf16.count)! >= 1{
            switch textField{
            case textfiledOne:
                textfieldTwo.becomeFirstResponder()
            case textfieldTwo:
                textfieldThree.becomeFirstResponder()
            case textfieldThree:
                textfieldfour.becomeFirstResponder()
            case textfieldfour:
                textfieldfour.resignFirstResponder()
            default:
                break
            }
        }else{

        }
    }
    
    private func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    @IBAction func resendAction(_ sender: Any)
    {
        presenterLoginService.attachView(view: self)
        presenterLoginService.getOtp(mobile_no: self.mobileNumber)
    }
    
    func startLoading()
    {
        /*Hide Activity View*/
        activityView.isHidden = false
        activityView.startAnimating()
    }
    
    func finishLoading()
    {
         activityView.isHidden = true
         activityView.stopAnimating()
    }
    
     func setLoginOtp(login_otp: String) {
          self.otp = login_otp
     }
     
     func setEmptyLogin(errorMessage: String) {
          AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
          })
     }
    
    @IBAction func verifyAction(_ sender: Any)
    {
        guard CheckValuesAreEmpty () else {
            return
        }
        
        self.otpSuccess ()
    }
    
    func CheckValuesAreEmpty () -> Bool{
        
        let attchedText = "\(textfiledOne.text ?? "")\(textfieldTwo.text ?? "")\(textfieldThree.text ?? "")\(textfieldfour.text ?? "")"

        
        guard Reachability.isConnectedToNetwork() == true else{
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
              })
              return false
        }
        
        guard self.textfiledOne.text?.count != 0 && self.textfieldTwo.text?.count != 0 && self.textfieldThree.text?.count != 0 && self.textfieldfour.text?.count != 0 else {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: "empty", complition: {
                
              })
             return false
         }
        
        guard attchedText == self.otp else {
            AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: Globals.OTPAlertMessage, complition: {
                
              })
             return false
         }
        
          return true
    }
    
    func otpSuccess ()
    {
        presenterOtpService.attachView(view: self)
        presenterOtpService.getOtpForOtpPage(mobile_no: self.mobileNumber, otp: self.otp)
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "to_constituentList")
        {
            let vc = segue.destination as! ConstituentList
            vc.navigationItem.title = "Select Constituent"
            vc.mobilenum = self.mobileNumber
            vc.otp = self.otp

        }
    }
    

}

extension OTP: OtpView
{
    func startLoadingOtp() {
        activityView.isHidden = false
        activityView.startAnimating()
    }
    func finishLoadingOtp() {
         activityView.isHidden = true
         activityView.stopAnimating()
    }
    func setOtp(otpValue: [OtpData]) {
         otpData = otpValue
         self.performSegue(withIdentifier: "to_constituentList", sender: self)
    }
    func setEmptyOtp(errorMessage: String) {
        AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
        })
    }
    
}
