//
//  NotificationPresenter.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct NotifiationData {
    let created_time : String
    let created_at : String
    let notification_text : String
}

protocol NotificationView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setNotification(notification: [NotifiationData])
    func setEmpty(errorMessage:String)
}

class NotificationPresenter {
    
        private let notificationService: NotificationService
        weak private var notificationView : NotificationView?

        init(notificationService:NotificationService) {
            self.notificationService = notificationService
        }
        
        func attachView(view:NotificationView) {
            notificationView = view
        }
        
        func detachView() {
            notificationView = nil
        }
        
      func getNotifiation(user_id:String) {
            self.notificationView?.startLoading()
            notificationService.callAPINotification(
              user_id: user_id, onSuccess: { (notification) in
                    self.notificationView?.finishLoading()
                    if (notification.count == 0){
                    } else {
                      let mappedUsers = notification.map {
                        return NotifiationData(created_time: "\($0.created_time ?? "")", created_at: "\($0.created_at ?? "")", notification_text: "\($0.notification_text ?? "")")
                         }
                        self.notificationView?.setNotification(notification: mappedUsers)
                    }
                },
                onFailure: { (errorMessage) in
                    self.notificationView?.finishLoading()
                    self.notificationView?.setEmpty(errorMessage: errorMessage)

                }
            )
        }

}
