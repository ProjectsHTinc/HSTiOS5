//
//  NotificationModel.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class NotificationModel {
      
      var id: String?
      var constituent_id: String?
      var created_at : String?
      var created_time : String?
      var notification_text : String?


      // MARK: Instance Method
      func loadFromDictionary(_ dict: [String: AnyObject])
      {
           if let data = dict["id"] as? String {
              self.id = data
           }
         
           if let data = dict["constituent_id"] as? String {
              self.constituent_id = data
           }
         
           if let data = dict["created_at"] as? String {
              self.created_at = data
           }
         
           if let data = dict["created_time"] as? String {
              self.created_time = data
           }
         
          if let data = dict["notification_text"] as? String {
             self.notification_text = data
          }
       
     }
     
     // MARK: Class Method
     class func build(_ dict: [String: AnyObject]) -> NotificationModel {
         let notificationModel = NotificationModel()
         notificationModel.loadFromDictionary(dict)
         return notificationModel
     }
}
