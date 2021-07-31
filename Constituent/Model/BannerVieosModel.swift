//
//  BannerVieosModel.swift
//  Constituent
//
//  Created by HappysanziMac on 31/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class BannerVideosModel {

       var id: String?
       var video_url: String?

       // MARK: Instance Method
       func loadFromDictionary(_ dict: [String: AnyObject])
       {
            if let data = dict["id"] as? String {
              self.id = data
            }
            if let data = dict["video_url"] as? String {
              self.video_url = data
            }
      }
      
      // MARK: Class Method
      class func build(_ dict: [String: AnyObject]) -> BannerVideosModel {
          let bannerImageModel = BannerVideosModel()
          bannerImageModel.loadFromDictionary(dict)
          return bannerImageModel
      }
}
