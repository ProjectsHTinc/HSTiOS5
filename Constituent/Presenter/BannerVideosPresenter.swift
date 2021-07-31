//
//  BannerVideosPresenter.swift
//  Constituent
//
//  Created by HappysanziMac on 31/07/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

struct BannerVideosdata:Codable {
    //let user_count : Int
    let video_url : String
}

protocol BannerVideosView: NSObjectProtocol {
    
    func startLoadingBannerImage()
    func finishLoadingBannerImage()
    func setBannerImage(banner_image: [BannerVideosdata])
    func setEmptyBannerImage(errorMessage:String)
}


class BannerVideosPresenter {

    private let bannerImageService: BannerVideosService
    weak private var bannerImageView : BannerVideosView?

    init(bannerImageService:BannerVideosService) {
        self.bannerImageService = bannerImageService
    }
    
    func attachView(view:BannerVideosView) {
        bannerImageView = view
    }
    
    func detachView() {
        bannerImageView = nil
    }
    
    func getBannerImage(user_id:String,dynamic_db:String) {
        self.bannerImageView?.startLoadingBannerImage()
        bannerImageService.callAPIBannerVideos(
            user_id: user_id,dynamic_db:dynamic_db,onSuccess: { (bannerimage) in
                self.bannerImageView?.finishLoadingBannerImage()
                if (bannerimage.count == 0){
                } else {
                  let mappedUsers = bannerimage.map {
                    return BannerVideosdata(video_url: "\($0.video_url ?? "")")
                     }
                  self.bannerImageView?.setBannerImage(banner_image: mappedUsers)
                }
            },
            onFailure: { (errorMessage) in
                self.bannerImageView?.finishLoadingBannerImage()
                self.bannerImageView?.setEmptyBannerImage(errorMessage: errorMessage)

            }
        )
    }
}
