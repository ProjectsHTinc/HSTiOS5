//
//  NewsFeedPresnter.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct NewsFeeddata:Codable {
    let image_file_name : String
    let title : String
    let news_date : String
    let details : String
}



protocol NewsFeedView: NSObjectProtocol {
    
    func startLoadingNewsFeed()
    func finishLoadingNewsFeed()
    func setNewsFeed(news_feed: [NewsFeeddata])
    func setEmptyNewsFeed(errorMessage:String)
}

class NewsFeedPresnter {
    
    private let newsFeedService: NewsFeedService
    weak private var newsFeedView : NewsFeedView?

    init(newsFeedService:NewsFeedService) {
        self.newsFeedService = newsFeedService
    }
    
    func attachView(view:NewsFeedView) {
        newsFeedView = view
    }
    
    func detachView() {
        newsFeedView = nil
    }

    func getNewsFeed(user_id:String) {
        self.newsFeedView?.startLoadingNewsFeed()
        newsFeedService.callAPINewsFeed(
          user_id: user_id, onSuccess: { (newsfeed) in
                self.newsFeedView?.finishLoadingNewsFeed()
                if (newsfeed.count == 0){
                } else {
                  let mappedUsers = newsfeed.map {
                    return NewsFeeddata(image_file_name: "\($0.image_file_name ?? "")", title: "\($0.title ?? "")", news_date: "\($0.news_date ?? "")", details:"\($0.details ?? "")")
                     }
                  self.newsFeedView?.setNewsFeed(news_feed: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.newsFeedView?.finishLoadingNewsFeed()
                self.newsFeedView?.setEmptyNewsFeed(errorMessage: errorMessage)

            }
        )
    }


}
