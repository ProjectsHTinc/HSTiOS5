//
//  Home.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import YoutubePlayer_in_WKWebView

class Home: UIViewController {

    var presenterProfile = ProfilePresenter(profileService: ProfileService())
    var profiledata = [ProfileData]()
    let presenterBannerVideo = BannerVideosPresenter(bannerImageService: BannerVideosService())
    var bannerVideo = [BannerVideosdata]()
    var grievanceCOUNT = [String]()
    var meetingCOUNT = [String]()
    var vedioArr = [String]()
    var veedioID = String()
    
    @IBOutlet var baseView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var grievanceView: UIView!
    @IBOutlet weak var meetingView: UIView!
    @IBOutlet weak var shadowNavView: UIView!
    @IBOutlet weak var grienavceCount: UILabel!
    @IBOutlet weak var meetingCount: UILabel!
    @IBOutlet weak var playerView: WKYTPlayerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let navigationBar = navigationController!.navigationBar
//        navigationBar.tintColor = UIColor.black
        // Do any additional setup after loading the view.
        /*Check Internet Connection*/
        let dynamic_db = UserDefaults.standard.object(forKey:"dynamicDBKey") ?? ""
        shadowNavView.layer.cornerRadius = 6
        shadowNavView.layer.shadowColor = UIColor.darkGray.cgColor
        shadowNavView.layer.shadowOpacity = 1.0
        shadowNavView.layer.shadowOffset = CGSize.zero
        shadowNavView.layer.shadowRadius = 3
        UINavigationBar.appearance().shadowImage = UIImage()
//        self.callAPIVedios()
        if dynamic_db as! String == ""
        {
 
        }
        else {
            GlobalVariables.shared.dynamic_Db = UserDefaults.standard.object(forKey: "dynamicDBKey") as! String
            print(GlobalVariables.shared.dynamic_Db)
        }
        self.setViewShadow()
        guard checkInterConnection () else {
            return
        }
        self.nameLabel.text = " Hi, \(GlobalVariables.shared.user_name)"
        self.callAPI()
        let tabBar = self.tabBarController!.tabBar
        tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: UIColor.black, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height:  tabBar.frame.height), lineThickness: 5.0, side: .top)
    }
        
    func checkInterConnection () -> Bool
    {
        guard Reachability.isConnectedToNetwork() == true else{
              self.baseView.isHidden = true
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
              return false
        }
              return true
    }
    
    func callAPI ()
    {
        guard Reachability.isConnectedToNetwork() == true else{
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
               return
        }
     
        presenterBannerVideo.attachView(view: self)
        presenterBannerVideo.getBannerImage(user_id:  GlobalVariables.shared.user_id,dynamic_db:GlobalVariables.shared.dynamic_Db)
        presenterProfile.attachView(view: self)
        presenterProfile.getProfile(user_id: GlobalVariables.shared.user_id,dynamic_db:GlobalVariables.shared.dynamic_Db)
    }
    
    
    func setViewShadow() {
        
        grievanceView.layer.cornerRadius = 6
        grievanceView.layer.shadowColor = UIColor.darkGray.cgColor
        grievanceView.layer.shadowOpacity = 0.5
        grievanceView.layer.shadowOffset = CGSize.zero
        grievanceView.layer.shadowRadius = 3
        
        meetingView.layer.cornerRadius = 6
        meetingView.layer.shadowColor = UIColor.darkGray.cgColor
        meetingView.layer.shadowOpacity = 0.5
        meetingView.layer.shadowOffset = CGSize.zero
        meetingView.layer.shadowRadius = 3
    }
    
    func callAPIVedios ()
    {
       
    }
    
    @objc public override func rightButtonClick()
    {
        self.performSegue(withIdentifier: "to_Notification", sender: self)
    }
    
    @IBAction func grievanceAction(_ sender: Any) {
        self.performSegue(withIdentifier: "to_Meeting", sender: self)
    }
    
    @IBAction func meetingAction(_ sender: Any) {
      
        self.performSegue(withIdentifier: "to_GrievnacesList", sender: self)
    }
    
//    @IBAction func plantDonationAction(_ sender: Any) {
//        self.performSegue(withIdentifier: "to_PlantDonation", sender: self)
//    }
//
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_GrievnacesList"){
            let _ = segue.destination as! Grievances
        }
    }
}

extension Home :ProfileView,BannerVideosView
{
  
    func startLoading() {
         self.view.activityStartAnimating()
    }
    
    func finishLoading() {
    }
    
    func setProfile(profile: [ProfileData]) {
         profiledata = profile
         self.view.activityStopAnimating()
        for data in profiledata {
            let grievanceCount = data.grievance_count
            let meetingCount = data.meeting_count
            let constituency_name = data.constituency_name
            
            grievanceCOUNT.append(grievanceCount)
            meetingCOUNT.append(meetingCount)
            GlobalVariables.shared.constituency_name = constituency_name
        }
//        grienavceCount.text = String(grievanceCOUNT[0])
//        meetingCount.text = String(meetingCOUNT[0])
    }
    
    func setEmpty(errorMessage: String) {
         AlertController.shared.showAlert(targetVc: self, title: Globals.alertTitle, message: errorMessage, complition: {
         })
    }
    
    func startLoadingBannerImage() {
         self.view.activityStartAnimating()
    }
    
    func finishLoadingBannerImage() {
        self.view.activityStopAnimating()
    }
    
    func setBannerImage(banner_image: [BannerVideosdata]) {
        bannerVideo = banner_image
//        self.view.activityStopAnimating()
        for data in bannerVideo {
            
            let bannerVideo = data.video_url
            self.vedioArr.append(bannerVideo)
        }
        print(vedioArr[0])
        playerView.load(withVideoId:vedioArr[0])
      
    }
    
    func setEmptyBannerImage(errorMessage: String) {
        
    }
}
