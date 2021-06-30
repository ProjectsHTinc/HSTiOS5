//
//  CheckConstituentIDModel.swift
//  Constituent
//
//  Created by HappysanziMac on 02/06/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class ConstiuentIdModel {
    
    var msg : String?
    var status : String?
    var dynamic_db: String?
    
    // MARK: Instance Method
    func loadFromDictionary(_ dict: [String: AnyObject])
    {
        if let data = dict["msg"] as? String {
            self.msg = data
        }
        if let data = dict["status"] as? String {
            self.status = data
        }
        if let data = dict["dynamic_db"] as? String {
            self.dynamic_db = data
        }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> ConstiuentIdModel {
        let clientUrl = ConstiuentIdModel()
        clientUrl.loadFromDictionary(dict)
        return clientUrl
    }

}

