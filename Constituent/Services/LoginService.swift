//
//  LoginService.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 18/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class LoginService {
      
      public func callAPILogin(mobile_no:String, onSuccess successCallback: ((_ login: LoginModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPILogin(
            mobile_no: mobile_no, onSuccess: { (loginData) in
                  successCallback?(loginData)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }
}
