//
//  UserDefault.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

enum UserDefaultsKey : String
{
      case userOtpListSessionkey
}

extension UserDefaults
{
    open func setOtpArray<T: Codable>(_ value: [T], forKey defaultName: String){
        let data = value.map { try? JSONEncoder().encode($0) }
        
        set(data, forKey: UserDefaultsKey.userOtpListSessionkey.rawValue)
    }
    
    open func getsOtpArrayData<T>(_ type: T.Type, forKey defaultName: String) -> [T] where T : Decodable {
        guard let encodedData = array(forKey: UserDefaultsKey.userOtpListSessionkey.rawValue) as? [Data] else {
            return []
        }
        
        return encodedData.map { try! JSONDecoder().decode(type, from: $0) }
    }
    
    func clearUserData()
    {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKey.userOtpListSessionkey.rawValue)
    }
}
