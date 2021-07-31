//
//  Profile.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SDWebImage

class Profile: UIViewController {
    
    var profiledata = [ProfileData]()
    var container: Container!

    @IBOutlet var userImageView: UIImageView!
    @IBOutlet var userName: UILabel!
    @IBOutlet var userNumber: UILabel!
    @IBOutlet var segmentControl: UISegmentedControl!
    @IBOutlet var containerViewOne: UIView!
    @IBOutlet var containerViewTwo: UIView!
    @IBOutlet weak var outletView: UIView!
    @IBOutlet weak var backView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        guard checkInterConnection () else {
            return
        }
        self.view.isHidden = false
//        self.navigationItem.title = "Profile"
        profiledata = UserDefaults.standard.getProfileInfo(ProfileData.self, forKey: UserDefaultsKey.profileInfokey.rawValue)
        self.setAllValues()
        self.setUpControl ()
      
        backView.addShadow(offset: CGSize.init(width: 0, height: 2), color: UIColor.gray, radius: 2.0, opacity: 0.35)
 
//        backView.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func checkInterConnection () -> Bool
    {
        guard Reachability.isConnectedToNetwork() == true else{
              self.view.isHidden = true
              AlertController.shared.offlineAlert(targetVc: self, complition: {
                //Custom action code
             })
              return false
        }
              return true
    }
    
    func setUpControl ()
    {
         segmentControl.selectedSegmentIndex = 0
//         segmentControl.backgroundColor = .white
//         segmentControl.tintColor = .white
         segmentControl.setTitleTextAttributes([
             NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
             NSAttributedString.Key.foregroundColor: UIColor.black
             ], for: .normal)

         segmentControl.setTitleTextAttributes([
             NSAttributedString.Key.font : UIFont(name: "Roboto-Bold", size: 13) as Any,
             NSAttributedString.Key.foregroundColor: UIColor.black
         ], for: .selected)
        
        segmentControl.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: "Roboto-Regular", size: 13) as Any,
            NSAttributedString.Key.foregroundColor: UIColor.black
        ], for: .normal)
    }
    
    func setAllValues ()
    {
        self.userImageView.sd_setImage(with: URL(string: profiledata[0].profile_picture), placeholderImage: UIImage(named: "placeholderNewsfeed.png"))
        self.userName.text = profiledata[0].full_name.capitalized
        self.userNumber.text = profiledata[0].constituency_name.capitalized
    }
    
    @IBAction func segmentAction(_ sender: Any) {
        if (segmentControl.selectedSegmentIndex == 0)
        {
            container!.segueIdentifierReceivedFromParent("profile")
        }
        else
        {
            container!.segueIdentifierReceivedFromParent("constituencyInfo")
        }
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "container" {
            container = (segue.destination as! Container)
            //For adding animation to the transition of containerviews you can use container's object property
            // animationDurationWithOptions and pass in the time duration and transition animation option as a tuple
            // Animations that can be used
            // .transitionFlipFromLeft, .transitionFlipFromRight, .transitionCurlUp
            // .transitionCurlDown, .transitionCrossDissolve, .transitionFlipFromTop
            container.animationDurationWithOptions = (0.5, .transitionCrossDissolve)
        }
    }
}
