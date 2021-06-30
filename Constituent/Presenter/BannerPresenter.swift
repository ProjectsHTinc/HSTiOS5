//
//  BannerPresenter.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct BannerImagedata:Codable {
    //let user_count : Int
    let gallery_image : String
}

protocol BannerImageView: NSObjectProtocol {
    
    func startLoadingBannerImage()
    func finishLoadingBannerImage()
    func setBannerImage(banner_image: [BannerImagedata])
    func setEmptyBannerImage(errorMessage:String)
}


class BannerPresenter {

    private let bannerImageService: BannerImageService
    weak private var bannerImageView : BannerImageView?

    init(bannerImageService:BannerImageService) {
        self.bannerImageService = bannerImageService
    }
    
    func attachView(view:BannerImageView) {
        bannerImageView = view
    }
    
    func detachView() {
        bannerImageView = nil
    }
    
    func getBannerImage(user_id:String,dynamic_db:String) {
        self.bannerImageView?.startLoadingBannerImage()
        bannerImageService.callAPIBannerImage(
            user_id: user_id,dynamic_db:dynamic_db,onSuccess: { (bannerimage) in
                self.bannerImageView?.finishLoadingBannerImage()
                if (bannerimage.count == 0){
                } else {
                  let mappedUsers = bannerimage.map {
                    return BannerImagedata(gallery_image: "\($0.gallery_image ?? "")")
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
