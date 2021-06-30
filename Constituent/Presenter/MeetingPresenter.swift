//
//  MeetingPresenter.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct MeetingData {
    let meeting_detail : String
    let meeting_date : String
    let meeting_status : String
    let meeting_title : String
    let created_at : String
}

protocol MeetingView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setMeeting(meeting: [MeetingData])
    func setEmpty(errorMessage:String)
}

class MeetingPresenter {
    
      private let meetingService: MeetingService
      weak private var meetingView : MeetingView?

      init(meetingService:MeetingService) {
          self.meetingService = meetingService
      }
      
      func attachView(view:MeetingView) {
          meetingView = view
      }
      
      func detachView() {
          meetingView = nil
      }
      
    func getMeeting(user_id:String,dynamic_db:String) {
          self.meetingView?.startLoading()
          meetingService.callAPIMeeting(
            user_id: user_id,dynamic_db:dynamic_db ,onSuccess: { (meeting) in
                  self.meetingView?.finishLoading()
                  if (meeting.count == 0){
                  } else {
                    let mappedUsers = meeting.map {
                        return MeetingData(meeting_detail: "\($0.meeting_detail ?? "")",meeting_date: "\($0.meeting_date ?? "")", meeting_status: "\($0.meeting_status ?? "")", meeting_title: "\($0.meeting_title ?? "")", created_at: "\($0.created_at ?? "")")
                       }
                    self.meetingView?.setMeeting(meeting: mappedUsers)
                  }
              },
              onFailure: { (errorMessage) in
                  self.meetingView?.finishLoading()
                  self.meetingView?.setEmpty(errorMessage: errorMessage)

              }
          )
      }

}
