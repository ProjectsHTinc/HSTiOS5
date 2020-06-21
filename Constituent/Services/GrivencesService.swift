//
//  GrivencesService.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 21/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class GrivencesService {
      
      public func callAPIGrivance(user_id:String, type:String, onSuccess successCallback: ((_ grievance: [GrievanceModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPIGrivance(
            user_id: user_id, type: type, onSuccess: { (grievance) in
                  successCallback?(grievance)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }
}
