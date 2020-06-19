//
//  Login.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 18/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class LoginModel {
    
    var msg : String?
    var status : String?
    var mobile_otp: String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["msg"] as? String {
            self.msg = data
        }
        if let data = dict["status"] as? String {
            self.status = data
        }
        if let data = dict["mobile_otp"] as? String {
            self.mobile_otp = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ClientUrlModel {
        let clientUrl = ClientUrlModel()
        clientUrl.loadFromDictionary(dict)
        return clientUrl
    }

}

