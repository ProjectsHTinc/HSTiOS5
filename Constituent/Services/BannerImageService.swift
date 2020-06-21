//
//  BannerImageService.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class BannerImageService {
    
      public func callAPIBannerImage(user_id:String, onSuccess successCallback: ((_ bannerImage: [BannerImageModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPIBannerImage(
            user_id: user_id, onSuccess: { (bannerimage) in
                  successCallback?(bannerimage)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }

}
