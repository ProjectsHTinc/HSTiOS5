//
//  NotificationService.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class NotificationService {
      
      public func callAPINotification(user_id:String,dynamic_db:String, onSuccess successCallback: ((_ notifiation: [NotificationModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPINotification(
            user_id: user_id,dynamic_db:dynamic_db, onSuccess: { (notification) in
                  successCallback?(notification)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }
}
