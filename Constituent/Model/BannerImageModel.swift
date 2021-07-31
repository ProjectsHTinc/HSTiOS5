//
//  BannerImageModel.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class BannerImageModel {

       var id: String?
       var banner_image: String?

       // MARK: Instance Method
       func loadFromDictionary(_ dict: [String: AnyObject])
       {
            if let data = dict["id"] as? String {
              self.id = data
            }
            if let data = dict["banner_image"] as? String {
              self.banner_image = data
            }
      }
      
      // MARK: Class Method
      class func build(_ dict: [String: AnyObject]) -> BannerImageModel {
          let bannerImageModel = BannerImageModel()
          bannerImageModel.loadFromDictionary(dict)
          return bannerImageModel
      }
}
