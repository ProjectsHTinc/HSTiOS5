//
//  GrievanceModel.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 21/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class GrievanceModel {

       var id: String?
       var seeker_info: String?
       var grievance_name : String?
       var sub_category_name : String?
       var petition_enquiry_no : String?
       var grievance_date : String?
       var reference_note : String?
       var description : String?
       var status : String?
       var grievance_type : String?


       // MARK: Instance Method
       func loadFromDictionary(_ dict: [String: AnyObject])
       {
            if let data = dict["id"] as? String {
               self.id = data
            }
          
            if let data = dict["seeker_info"] as? String {
               self.seeker_info = data
            }
          
            if let data = dict["grievance_name"] as? String {
               self.grievance_name = data
            }
          
            if let data = dict["sub_category_name"] as? String {
               self.sub_category_name = data
            }
          
           if let data = dict["petition_enquiry_no"] as? String {
              self.petition_enquiry_no = data
           }
        
           if let data = dict["grievance_date"] as? String {
               self.grievance_date = data
           }
        
           if let data = dict["reference_note"] as? String {
              self.reference_note = data
           }
        
           if let data = dict["description"] as? String {
              self.description = data
           }
        
           if let data = dict["status"] as? String {
              self.status = data
           }
        
           if let data = dict["grievance_type"] as? String {
              self.grievance_type = data
           }
      }
      
      // MARK: Class Method
      class func build(_ dict: [String: AnyObject]) -> GrievanceModel {
          let grievanceModel = GrievanceModel()
          grievanceModel.loadFromDictionary(dict)
          return grievanceModel
      }
}
