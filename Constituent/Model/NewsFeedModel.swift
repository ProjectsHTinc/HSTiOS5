//
//  NewsFeedModel.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class NewsFeedModel {
    
     var id: String?
     var news_date: String?
     var image_file_name : String?
     var title : String?
     var details : String?
     var date_elapsed : String?

     // MARK: Instance Method
     func loadFromDictionary(_ dict: [String: AnyObject])
     {
          if let data = dict["id"] as? String {
             self.id = data
          }
        
          if let data = dict["news_date"] as? String {
             self.news_date = data
          }
        
          if let data = dict["image_file_name"] as? String {
             self.image_file_name = data
          }
        
          if let data = dict["title"] as? String {
             self.title = data
          }
        
         if let data = dict["details"] as? String {
            self.details = data
         }
        
         if let data = dict["date_elapsed"] as? String {
            self.date_elapsed = data
         }
    }
    
    // MARK: Class Method
    class func build(_ dict: [String: AnyObject]) -> NewsFeedModel {
        let newsFeedModel = NewsFeedModel()
        newsFeedModel.loadFromDictionary(dict)
        return newsFeedModel
    }

}
