//
//  CheckConstituentIDPresenter.swift
//  Constituent
//
//  Created by HappysanziMac on 02/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

struct ConstiuentIdData {
    let mobile_otp: String
}

protocol ConstiuentIdView : NSObjectProtocol {

    func startLoading()
    func finishLoading()
    func setLoginOtp(dynamic_db:String)
    func setEmptyLogin(errorMessage:String)
}

class ConstiuentIdPresenter {

      private let constiuentIdService:ConstiuentIdService
      weak private var constiuentIdView : ConstiuentIdView?

     init(constiuentIdService:ConstiuentIdService) {
        self.constiuentIdService = constiuentIdService
     }

     func attachView(view:ConstiuentIdView) {
        constiuentIdView = view
     }

    func detachViewClientUrl() {
        constiuentIdView = nil
    }
    
    func getOtp(constituency_code:String) {
        self.constiuentIdView?.startLoading()
        constiuentIdService.callAPIConstiuentId(
            constituency_code: constituency_code, onSuccess: { (login) in
                self.constiuentIdView?.setLoginOtp(dynamic_db: login.dynamic_db!)
                self.constiuentIdView?.finishLoading()
            },
            onFailure: { (errorMessage) in
                self.constiuentIdView?.setEmptyLogin(errorMessage: errorMessage)
                self.constiuentIdView?.finishLoading()

            }
        )
    }

}
