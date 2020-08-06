//
//  AppVersionPresenter.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 24/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

struct appVersionData {
    let status: String
}
protocol AppVersionView : NSObjectProtocol {

    func startLoadingAppver()
    func finishLoadingAppver()
    func setAppversion(status:String)
    func setEmptyAppver(errorMessage:String)
}

class AppVersionPresenter {
    
        private let appVersionService:AppVersionService
        weak private var appVersionView : AppVersionView?

       init(appVersionService:AppVersionService) {
          self.appVersionService = appVersionService
       }

       func attachView(view:AppVersionView) {
           appVersionView = view
       }

      func detachViewClientUrl() {
          appVersionView = nil
      }
      
      func getAppVersion(version_code:String) {
          self.appVersionView?.startLoadingAppver()
          appVersionService.callAPIAppversion(
              version_code: version_code, onSuccess: { (appversion) in
                  self.appVersionView?.setAppversion(status: appversion.status!)
                  self.appVersionView?.finishLoadingAppver()
              },
              onFailure: { (errorMessage) in
                  self.appVersionView?.setEmptyAppver(errorMessage: errorMessage)
                  self.appVersionView?.finishLoadingAppver()

              }
          )
      }

}
