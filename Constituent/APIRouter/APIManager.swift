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

let MAIN_URL = "http://happysanz.in/superadmingms/api"

class APIManager: NSObject {
      
      static let instance = APIManager()
      
      enum RequestMethod {
          case get
          case post
      }
    
      enum Endpoint: String {
          case constituencyList = "/list"
          case clientUrl = "/details"
          case logintUrl = "apiconstituentios/mobile_check"
          case otpUrl = "apiconstituentios/mobile_verify"
          case bannerImageUrl = "apiconstituentios/view_banners"
          case newsFeedUrl = "apiconstituentios/newsfeed_list"
      }
      
      // MARK: GET CONSTITUENCY LIST RESPONSE
      func callAPIGetConstituencyList(partyID:String,onSuccess successCallback: ((_ constituencyName: [ConstituencyModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
          // Build URL
          let url = MAIN_URL + Endpoint.constituencyList.rawValue
          // Set Parameters
          let parameters: Parameters =  ["party_id": partyID]
          // call API
          self.createRequestForConstituencyList(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
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
      
      // MARK: Make CONSTITUENCY LIST REQUEST
      func createRequestForConstituencyList(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
      {
          Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
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
    
    //MARK: GET CLIENT URL RESPONSE
    func callAPIGetClientUrl(select_ID:String,onSuccess successCallback: ((_ client_url: [ClientUrlModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = MAIN_URL + Endpoint.clientUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["id": select_ID]
        // call API
        self.createRequestGetClientUrl(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
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
    
    // MARK: Make CLIENT URL REQUEST
    func createRequestGetClientUrl(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
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
    
    //MARK: GET LOGIN RESPONSE
    func callAPILogin(mobile_no:String,onSuccess successCallback: ((_ login: LoginModel) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.logintUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["mobile_no": mobile_no]
        // call API
        self.createRequestForLogin(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
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
    
    
    // MARK: Make LOGIN REQUEST
    func createRequestForLogin(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
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
    
    //MARK: GET OTP RESPONSE
    func callAPIOTP(mobile_no:String, otp:String, onSuccess successCallback: ((_ otp: [OTPModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.otpUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["mobile_no": mobile_no,"otp": otp, "device_id": GlobalVariables.shared.Devicetoken, "mobile_type": Globals.mobileType]
        // call API
        self.createRequestForOTP(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
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
    
    
    // MARK: Make OTP REQUEST
    func createRequestForOTP(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
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
    
    //MARK: GET BANNER IMAGE RESPONSE
    func callAPIBannerImage(user_id:String, onSuccess successCallback: ((_ bannerImage: [BannerImageModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.bannerImageUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id]
        // call API
        self.createRequestForOTP(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
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
    
    
    // MARK: Make NEWS FEED REQUEST
    func createRequestForBannerImage(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
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
    
    //MARK: GET NEWS FEED RESPONSE
    func callAPINewsFeed(user_id:String, onSuccess successCallback: ((_ newsFeed: [NewsFeedModel]) -> Void)?,onFailure failureCallback: ((_ errorMessage: String) -> Void)?) {
        // Build URL
        let url = GlobalVariables.shared.CLIENTURL + Endpoint.newsFeedUrl.rawValue
        // Set Parameters
        let parameters: Parameters =  ["user_id": user_id]
        // call API
        self.createRequestForOTP(url, method: .post, headers: nil, parameters: parameters as? [String : String], onSuccess: {(responseObject: JSON) -> Void in
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
    
    
    // MARK: Make NEWS FEED REQUEST
    func createRequestForNewsFeed(_ url: String,method: HTTPMethod,headers: [String: String]?,parameters: [String:String]?,onSuccess successCallback: ((JSON) -> Void)?,onFailure failureCallback: ((String) -> Void)?)
    {
        Alamofire.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
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
}
