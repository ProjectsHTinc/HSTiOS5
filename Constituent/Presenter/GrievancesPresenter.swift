//
//  GrievancesPresenter.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 21/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct GrievanceData {
    //let user_count : Int
    let grievance_name : String
    let petition_enquiry_no : String
    let reference_note : String
    let description : String
    let status : String
    let seeker_info: String
    let sub_category_name: String
    let grievance_type: String
}

protocol GrievanceView: NSObjectProtocol {
    
    func startLoadingGrievance()
    func finishLoadingGrievance()
    func setBannerGrievance(grievance_Data: [GrievanceData])
    func setEmptyGrievance(errorMessage:String)
}


class GrievancesPresenter {
    
      private let grivencesService: GrivencesService
      weak private var grievanceView : GrievanceView?

      init(grivencesService:GrivencesService) {
          self.grivencesService = grivencesService
      }
      
      func attachView(view:GrievanceView) {
          grievanceView = view
      }
      
      func detachView() {
          grievanceView = nil
      }
      
    func getGrievances(user_id:String, type:String) {
          self.grievanceView?.startLoadingGrievance()
          grivencesService.callAPIGrivance(
            user_id: user_id, type: type, onSuccess: { (grievances) in
                  self.grievanceView?.finishLoadingGrievance()
                  if (grievances.count == 0){
                  } else {
                    let mappedUsers = grievances.map {
                        return GrievanceData(grievance_name: "\($0.grievance_name ?? "")", petition_enquiry_no: "\($0.petition_enquiry_no ?? "")", reference_note: "\($0.reference_note ?? "")", description: "\($0.description ?? "")", status: "\($0.status ?? "")", seeker_info: "\($0.seeker_info ?? "")", sub_category_name: "\($0.sub_category_name ?? "")", grievance_type: "\($0.grievance_type ?? "")")
                       }
                    self.grievanceView?.setBannerGrievance(grievance_Data: mappedUsers)
                  }
              },
              onFailure: { (errorMessage) in
                  self.grievanceView?.finishLoadingGrievance()
                  self.grievanceView?.setEmptyGrievance(errorMessage: errorMessage)

              }
          )
      }

}
