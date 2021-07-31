//
//  BannerVideosService.swift
//  Constituent
//
//  Created by HappysanziMac on 31/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class BannerVideosService {
    
      public func callAPIBannerVideos(user_id:String, dynamic_db:String,onSuccess successCallback: ((_ bannerImage: [BannerVideosModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPIBannerVideos(
            user_id: user_id,dynamic_db:dynamic_db, onSuccess: { (bannerimage) in
                  successCallback?(bannerimage)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }

}
