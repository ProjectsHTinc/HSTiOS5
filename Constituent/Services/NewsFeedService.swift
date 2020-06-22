//
//  NewsFeedService.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class NewsFeedService {
    
      public func callAPINewsFeed(user_id:String, onSuccess successCallback: ((_ bewsFeed: [NewsFeedModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          APIManager.instance.callAPINewsFeed(
            user_id: user_id, onSuccess: { (newsfeed) in
                  successCallback?(newsfeed)
              },
              onFailure: { (errorMessage) in
                  failureCallback?(errorMessage)
              }
          )
      }

}
