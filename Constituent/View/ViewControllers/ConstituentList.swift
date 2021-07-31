//
//  ConstituentList.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 18/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SDWebImage

class ConstituentList: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var otp = String()
    var mobilenum = String()
    var otpData = [OtpData]()
    var from = String()

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.view.isHidden = false
        UINavigationBar.appearance().shadowImage = UIImage()
         if from == "Otp"
         {
            self.title = "Select Constituent"
            /*Set navigation back button hidden*/
//            self.navigationItem.setHidesBackButton(true, animated: true);
         }
         else
         {
            self.title = "Select Constituent"
//            self.addCustomizedBackBtn(title:"  Select Constituent")
            /*Show navigation back button hidden*/
//            self.navigationItem.setHidesBackButton(false, animated: true);

         }
         otpData = UserDefaults.standard.getsOtpArrayData(OtpData.self, forKey: UserDefaultsKey.userOtpListSessionkey.rawValue)
         self.tableView.reloadData()
         self.tableView.backgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return otpData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConstituentCell
         let constituent = otpData[indexPath.row]
         cell.name.text = constituent.full_name.capitalized
         cell.serialnumber.text = ("Serial Number - \(constituent.serial_no)")
         cell.dob.text = ("Date of Birth - \(constituent.dob)")
         cell.constituentImage.sd_setImage(with: URL(string: constituent.profile_picture), placeholderImage: UIImage(named: "placeholder.png"))
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
         let index = otpData[indexPath.row]
         UserDefaults.standard.set(index.id, forKey: UserDefaultsKey.userIDkey.rawValue)
         GlobalVariables.shared.user_id = UserDefaults.standard.object(forKey: UserDefaultsKey.userIDkey.rawValue) as! String
         UserDefaults.standard.set(index.full_name, forKey: UserDefaultsKey.userNamekey.rawValue)
         GlobalVariables.shared.user_name = UserDefaults.standard.object(forKey: UserDefaultsKey.userNamekey.rawValue) as! String
         self.performSegue(withIdentifier: "to_Tabbar", sender: self)

    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if (segue.identifier == "to_Tabbar")
        {
            let _ = segue.destination as! TabbarController
        }
    }
    

}

