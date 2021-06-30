//
//  OTPService.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 18/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class OTPService {

    public func callAPIOTP(mobile_no:String, otp:String,dynamic_db:String, onSuccess successCallback: ((_ otp: [OTPModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPIOTP(
            mobile_no: mobile_no, otp: otp, dynamic_db: dynamic_db, onSuccess: { (loginData) in
                  successCallback?(loginData)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }
}
