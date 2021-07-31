//
//  ProfileModel.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 23/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ProfileModel {

       var id: String?
       var full_name: String?
       var address : String?
       var pin_code : String?
       var father_husband_name : String?
       var mobile_no : String?
       var whatsapp_no : String?
       var email_id : String?
       var religion_name : String?
       var constituency_name : String?
       var paguthi_name : String?
       var ward_name : String?
       var booth_name : String?
       var booth_address : String?
       var serial_no : String?
       var aadhaar_no : String?
       var voter_id_no : String?
       var dob : String?
       var gender : String?
       var profile_picture : String?
       var grievance_count : String?
       var meeting_count : String?


       // MARK: Instance Method
       func loadFromDictionary(_ dict: [String: AnyObject])
       {
            if let data = dict["id"] as? String {
               self.id = data
            }
          
            if let data = dict["full_name"] as? String {
               self.full_name = data
            }
          
            if let data = dict["address"] as? String {
               self.address = data
            }
          
            if let data = dict["pin_code"] as? String {
               self.pin_code = data
            }
          
            if let data = dict["father_husband_name"] as? String {
               self.father_husband_name = data
            }
        
            if let data = dict["mobile_no"] as? String {
               self.mobile_no = data
            }
            
            if let data = dict["whatsapp_no"] as? String {
               self.whatsapp_no = data
            }
            
            if let data = dict["email_id"] as? String {
               self.email_id = data
            }
            
            if let data = dict["religion_name"] as? String {
               self.religion_name = data
            }
            
            if let data = dict["constituency_name"] as? String {
               self.constituency_name = data
            }
            
            if let data = dict["paguthi_name"] as? String {
               self.paguthi_name = data
            }
            
            if let data = dict["ward_name"] as? String {
               self.ward_name = data
            }
            
            if let data = dict["booth_name"] as? String {
               self.booth_name = data
            }
            
            if let data = dict["booth_address"] as? String {
               self.booth_address = data
            }
            
            if let data = dict["serial_no"] as? String {
               self.serial_no = data
            }
            
            if let data = dict["aadhaar_no"] as? String {
               self.aadhaar_no = data
            }
            
            if let data = dict["voter_id_no"] as? String {
               self.voter_id_no = data
            }
            
            if let data = dict["dob"] as? String {
               self.dob = data
            }
            
            if let data = dict["gender"] as? String {
               self.gender = data
            }
            if let data = dict["profile_picture"] as? String {
               self.profile_picture = data
            }
            if let data = dict["grievance_count"] as? String {
               self.grievance_count = data
            }
            if let data = dict["meeting_count"] as? String {
               self.meeting_count = data
        }
      }
  
      // MARK: Class Method
      class func build(_ dict: [String: AnyObject]) -> ProfileModel {
            let profileModel = ProfileModel()
            profileModel.loadFromDictionary(dict)
            return profileModel
      }
}
