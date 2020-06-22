//
//  PlantDonationService.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 22/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class PlantDonationService {
    
     public func callAPIPlant(user_id:String, onSuccess successCallback: ((_ meeting: PlantDonationModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        APIManager.instance.callAPIPlant(
          user_id: user_id, onSuccess: { (meeting) in
                successCallback?(meeting)
            },
            onFailure: { (errorMessage) in
                failureCallback?(errorMessage)
            }
        )
    }

}
