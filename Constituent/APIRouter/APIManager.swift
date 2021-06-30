//
//  APIManager.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 15/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Foundation

let MAIN_URL = "https://happysanz.in/gms/apiconstituent"

class APIManager: NSObject {
      
      static let instance = APIManager()
      var manager: SessionManager {
          let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 3.0
          return manager
      }
      
      enum RequestMethod {
          case get
          case post
      }
//    apiconstituentios
      enum Endpoint: String {
          case constituencyList = "/list"
          case checkConstituentId = "/chk_constituency_code"
          case clientUrl = "/details"
          case logintUrl = "/mobile_check"
          case appversionUrl = "/version_check"
          case otpUrl = "/mobile_verify"
          case bannerImageUrl = "/view_banners"
          case newsFeedUrl = "/newsfeed_list"
          case grivencesUrl = "/greivance_list"
          case meetingUrl = "/meeting_list"
          case plantDonationUrl = "/get_plant_donation"
          case notificationUrl = "/notification_list"
          case profilrUrl = "/user_details"
      }
    
    // MARK: MAKE CONSTITUENCY LIST REQUEST
    func createRequest(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        manager.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            print(responseObject)
            
            if responseObject.result.isSuccess
            {
                let resJson = JSON(responseObject.result.value!)
                successCallback?(resJson)
            }
            
            if responseObject.result.isFailure
            {
               let error : Error = responseObject.result.error!
                failureCallback!(error.localizedDescription)
            }
        }
    }
  
      
      // MARK: GET CONSTITUENCY LIST RESPONSE
      func callAPIGetConstituencyList(partyID:String,onSuccess successCallback: ((_ constituencyName: [ConstituencyModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          // Build URL
          let url = MAIN_URL + Endpoint.constituencyList.rawValue
          // Set Parameters
          let parameters: Parameters =  ["party_id": partyID]
          // call API
          self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
          // Create dictionary
          print(responseObject)
            
            guard let msg = responseObject["msg"].string, msg == "constituency found" else{
                failureCallback?(responseObject["msg"].string!)
                return
          }

          if let responseDict = responseObject["data"].arrayObject
            {
                  let constituencyList = responseDict as! [[String:AnyObject]]
                  // Create object
                  var data = [ConstituencyModel]()
                  for item in constituencyList {
                      let single = ConstituencyModel.build(item)
                      data.append(single)
                  }
                  // Fire callback
                  successCallback?(data)
             } else {
                  failureCallback?("An error has occured.")
              }
          },
          onFailure: {(errorMessage: String) -> Void in
              failureCallback?(errorMessage)
          }
       )
    }
      
    //MARK: GET CLIENT URL RESPONSE
    func callAPIGetClientUrl(select_ID:String,onSuccess successCallback: ((_ client_url: [ClientUrlModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.clientUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["id": select_ID]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "constituency found" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }

        if let responseDict = responseObject["data"].arrayObject
          {
                let clientUrlModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ClientUrlModel]()
                for item in clientUrlModel {
                    let single = ClientUrlModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
        }
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    

    //MARK: GET LOGIN RESPONSE
    func callAPILogin(mobile_no:String,dynamic_db:String,onSuccess successCallback: ((_ login: LoginModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.logintUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["mobile_no": mobile_no,"dynamic_db":dynamic_db]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "details found" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
            let mobile_otp =  responseObject["mobile_otp"].string
            let message =  responseObject["msg"].string
            let status =  responseObject["status"].string

            let sendToModel = LoginModel()
            sendToModel.mobile_otp = mobile_otp
            sendToModel.msg = message
            sendToModel.status = status

            successCallback?(sendToModel)
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    func callAPIConstituentId(constituency_code:String,onSuccess successCallback: ((_ login: ConstiuentIdModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.checkConstituentId.rawValue
        // Set Parameters
        let parameters: Parameters =  ["constituency_code": constituency_code]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Login Successfully" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            if let dynamicDB = responseObject["dynamic_db"]["dynamic_db"].string
            {
                UserDefaults.standard.setValue(dynamicDB, forKey: "dynamicDBKey")
                GlobalVariables.shared.dynamic_Db = responseObject["dynamic_db"]["dynamic_db"].string!
            }
            
            let dynamic_db =  responseObject["dynamic_db"]["dynamic_db"].string
            let message =  responseObject["msg"].string
            let status =  responseObject["status"].string

            let sendToModel = ConstiuentIdModel()
            sendToModel.dynamic_db = dynamic_db
            sendToModel.msg = message
            sendToModel.status = status

            successCallback?(sendToModel)
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
  
    //MARK: GET APPVERSION RESPONSE
    func callAPIAppversion(version_code:String, onSuccess successCallback: ((_ appversion: AppVersionModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.logintUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["version_code": version_code]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["status"].string, msg == "error" else{
              failureCallback?(responseObject["status"].string!)
              return
        }
            
            let status =  responseObject["status"].string
            let sendToModel = AppVersionModel()
            sendToModel.status = status
            successCallback?(sendToModel)
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
  
    //MARK: GET OTP RESPONSE
    func callAPIOTP(mobile_no:String, otp:String,dynamic_db:String, onSuccess successCallback: ((_ otp: [OTPModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.otpUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["mobile_no": mobile_no,"otp": otp, "device_id": GlobalVariables.shared.Devicetoken, "mobile_type": Globals.mobileType,"dynamic_db":dynamic_db]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "details found" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
          GlobalVariables.shared.userCount = responseObject["user_count"].int!
            
          if let responseDict = responseObject["user_details"].arrayObject
          {
                let otpModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [OTPModel]()
                for item in otpModel {
                    let single = OTPModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    
  
    //MARK: GET BANNER IMAGE RESPONSE
    func callAPIBannerImage(user_id:String,dynamic_db:String, onSuccess successCallback: ((_ bannerImage: [BannerImageModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.bannerImageUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id,"dynamic_db":dynamic_db]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "Banner image found" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
                        
          if let responseDict = responseObject["banner_image"].arrayObject
          {
                let bannerImageModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [BannerImageModel]()
                for item in bannerImageModel {
                    let single = BannerImageModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
 
    //MARK: GET NEWS FEED RESPONSE
    func callAPINewsFeed(user_id:String,dynamic_db:String, onSuccess successCallback: ((_ newsFeed: [NewsFeedModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.newsFeedUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id,"dynamic_db":dynamic_db]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "list found" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
                        
          if let responseDict = responseObject["news_list"].arrayObject
          {
                let newsFeedModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [NewsFeedModel]()
                for item in newsFeedModel {
                    let single = NewsFeedModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }

    //MARK: GET GRIVENCES RESPONSE
    func callAPIGrivance(user_id:String, type:String,dynamic_db:String, onSuccess successCallback: ((_ grievance: [GrievanceModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.grivencesUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id,"type": type,"dynamic_db":dynamic_db]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "list found" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
                        
          if let responseDict = responseObject["grievance_list"].arrayObject
          {
                let grievanceModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [GrievanceModel]()
                for item in grievanceModel {
                    let single = GrievanceModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    //MARK: GET MEETING RESPONSE
    func callAPIMeeting(user_id:String,dynamic_db:String, onSuccess successCallback: ((_ meeting: [MeetingModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.meetingUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id,"dynamic_db":dynamic_db]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "list found" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
                        
          if let responseDict = responseObject["meeting_list"].arrayObject
          {
                let meetingModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [MeetingModel]()
                for item in meetingModel {
                    let single = MeetingModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }

    //MARK: GET PLANT DONATION RESPONSE
    func callAPIPlant(user_id:String,dynamic_db:String, onSuccess successCallback: ((_ plant: PlantDonationModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.plantDonationUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id,"dynamic_db":dynamic_db]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "plant donation found" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
            
            let name_of_plant =  responseObject["details"]["name_of_plant"].string
            let no_of_plant =   responseObject["details"]["no_of_plant"].string
            let created_at =   responseObject["details"]["created_at"].string

            let sendToModel = PlantDonationModel()
            sendToModel.name_of_plant = name_of_plant
            sendToModel.no_of_plant = no_of_plant
            sendToModel.created_at = created_at
            
            successCallback?(sendToModel)
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
    
    //MARK: GET NOTIFICATION RESPONSE
    func callAPINotification(user_id:String,dynamic_db:String, onSuccess successCallback: ((_ notification: [NotificationModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.notificationUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id,"dynamic_db":dynamic_db]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "list found" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
                        
          if let responseDict = responseObject["notification_list"].arrayObject
          {
                let notificationModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [NotificationModel]()
                for item in notificationModel {
                    let single = NotificationModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
        
    }
 
    //MARK: GET PROFILE RESPONSE
    func callAPIProfile(user_id:String,dynamic_db:String, onSuccess successCallback: ((_ profile: [ProfileModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.profilrUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id,"dynamic_db":dynamic_db]
        // call API
        self.createRequest(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
        // Create dictionary
        print(responseObject)
          
          guard let msg = responseObject["msg"].string, msg == "details found" else{
              failureCallback?(responseObject["msg"].string!)
              return
        }
                        
          if let responseDict = responseObject["user_details"].arrayObject
          {
                let profileModel = responseDict as! [[String:AnyObject]]
                // Create object
                var data = [ProfileModel]()
                for item in profileModel {
                    let single = ProfileModel.build(item)
                    data.append(single)
                }
                // Fire callback
              successCallback?(data)
           } else {
                failureCallback?("An error has occured.")
            }
            
        },
        onFailure: {(errorMessage: String) -> Void in
            failureCallback?(errorMessage)
        }
      )
    }
}
