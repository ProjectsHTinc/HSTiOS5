//
//  ProfilePresenter.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 23/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct ProfileData:Codable {
    let id : String
    let full_name : String
    let address : String
    let pin_code : String
    let father_husband_name : String
    let mobile_no : String
    let whatsapp_no : String
    let email_id : String
    let religion_name : String
    let constituency_name : String
    let paguthi_name : String
    let ward_name : String
    let booth_name : String
    let booth_address : String
    let serial_no : String
    let aadhaar_no : String
    let voter_id_no : String
    let dob : String
    let gender : String
    let profile_picture : String
}

protocol ProfileView: NSObjectProtocol {
    
    func startLoading()
    func finishLoading()
    func setProfile(profile: [ProfileData])
    func setEmpty(errorMessage:String)
}

class ProfilePresenter {

        private let profileService: ProfileService
        weak private var profileView : ProfileView?

        init(profileService:ProfileService) {
            self.profileService = profileService
        }
        
        func attachView(view:ProfileView) {
            profileView = view
        }
        
        func detachView() {
            profileView = nil
        }
        
      func getProfile(user_id:String) {
            self.profileView?.startLoading()
            profileService.callAPIProfile(
              user_id: user_id, onSuccess: { (profile) in
                    self.profileView?.finishLoading()
                    if (profile.count == 0){
                    } else {
                      let mappedUsers = profile.map {
                        return ProfileData(id: "\($0.id ?? "")", full_name: "\($0.full_name ?? "")", address: "\($0.address ?? "")", pin_code: "\($0.pin_code ?? "")", father_husband_name: "\($0.father_husband_name ?? "")", mobile_no: "\($0.mobile_no ?? "")", whatsapp_no: "\($0.whatsapp_no ?? "")", email_id: "\($0.email_id ?? "")", religion_name: "\($0.religion_name ?? "")", constituency_name: "\($0.constituency_name ?? "")", paguthi_name: "\($0.paguthi_name ?? "")", ward_name: "\($0.ward_name ?? "")", booth_name: "\($0.booth_name ?? "")", booth_address: "\($0.booth_address ?? "")", serial_no: "\($0.serial_no ?? "")", aadhaar_no: "\($0.aadhaar_no ?? "")", voter_id_no: "\($0.voter_id_no ?? "")", dob: "\($0.dob ?? "")", gender: "\($0.gender ?? "")", profile_picture: "\($0.profile_picture ?? "")")
                         }
                      self.profileView?.setProfile(profile: mappedUsers)
                    }
                },
                onFailure: { (errorMessage) in
                    self.profileView?.finishLoading()
                    self.profileView?.setEmpty(errorMessage: errorMessage)

                }
            )
        }
}
