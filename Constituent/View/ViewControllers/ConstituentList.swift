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

    var otpDatas = UserDefaults.standard.getsOtpArrayData(OtpData.self, forKey: UserDefaultsKey.userOtpListSessionkey.rawValue)

    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.backgroundColor = .white
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return otpDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ConstituentCell
         let constituent = otpDatas[indexPath.row]
         cell.name.text = constituent.full_name
         cell.serialnumber.text = ("Serial Number - \(constituent.id)")
         cell.dob.text = ("Date of Birth - \(constituent.dob)")
         cell.constituentImage.sd_setImage(with: URL(string: constituent.profile_picture), placeholderImage: UIImage(named: "placeholder.png"))
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
         let index = otpDatas[indexPath.row]
         GlobalVariables.shared.user_id = index.id
         GlobalVariables.shared.user_name = index.full_name
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

