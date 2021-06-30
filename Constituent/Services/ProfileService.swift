//
//  ProfileService.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 23/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ProfileService {

      public func callAPIProfile(user_id:String,dynamic_db:String, onSuccess successCallback: ((_ profile: [ProfileModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPIProfile(
            user_id: user_id,dynamic_db:dynamic_db, onSuccess: { (profile) in
                  successCallback?(profile)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }
}
