//
//  CheckConstituentIDService.swift
//  Constituent
//
//  Created by HappysanziMac on 02/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//
import UIKit

class ConstiuentIdService {
      
      public func callAPIConstiuentId(constituency_code:String, onSuccess successCallback: ((_ login: ConstiuentIdModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPIConstituentId(
            constituency_code: constituency_code, onSuccess: { (ConstiuentIdData) in
                  successCallback?(ConstiuentIdData)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }
}
