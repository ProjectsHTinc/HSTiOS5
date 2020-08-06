//
//  OTPPresenter.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 18/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct OtpData:Codable {
    //let user_count : Int
    let full_name : String
    let id : String
    let profile_picture : String
    let dob : String
    let serial_no : String

}

protocol OtpView: NSObjectProtocol {
    
    func startLoadingOtp()
    func finishLoadingOtp()
    func setOtp(otpValue: [OtpData])
    func setEmptyOtp(errorMessage:String)
}

class OTPPresenter {

      private let oTPService: OTPService
      weak private var otpView : OtpView?
      
      init(oTPService:OTPService) {
          self.oTPService = oTPService
      }
      
      func attachView(view:OtpView) {
          otpView = view
      }
      
      func detachView() {
          otpView = nil
      }
    
      func getOtpForOtpPage(mobile_no:String, otp:String) {
          self.otpView?.startLoadingOtp()
          oTPService.callAPIOTP(
            mobile_no: mobile_no, otp: otp, onSuccess: { (otp) in
                  self.otpView?.finishLoadingOtp()
                  if (otp.count == 0){
                  } else {
                    let mappedUsers = otp.map {
                        return OtpData(full_name: "\($0.full_name ?? "")", id: "\($0.id ?? "")", profile_picture: "\($0.profile_picture ?? "")", dob: "\($0.dob ?? "")", serial_no: "\($0.serial_no ?? "")")
                       }
                    self.otpView?.setOtp(otpValue: mappedUsers)
                    UserDefaults.standard.setOtpArray(mappedUsers, forKey: UserDefaultsKey.userOtpListSessionkey.rawValue)
                  }
              },
              onFailure: { (errorMessage) in
                  self.otpView?.finishLoadingOtp()
                  self.otpView?.setEmptyOtp(errorMessage: errorMessage)

              }
          )
      }
}
