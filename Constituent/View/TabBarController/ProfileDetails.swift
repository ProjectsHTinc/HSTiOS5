//
//  ProfileDetails.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 23/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit

class ProfileDetails: UITableViewController {
    
    var profiledata = [ProfileData]()

    @IBOutlet var fatherName: UITextField!
    @IBOutlet var guardianName: UITextField!
    @IBOutlet var emailId: UITextField!
    @IBOutlet var phoneNumber: UITextField!
    @IBOutlet var watsappNumber: UITextField!
    @IBOutlet var dob: UITextField!
    @IBOutlet var gender: UITextField!
    @IBOutlet var religion: UITextField!
    @IBOutlet var address: UITextField!
    @IBOutlet var pincode: UITextField!
    @IBOutlet var voterId: UITextField!
    @IBOutlet var adharNumber: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.tableView.backgroundColor = .white
        profiledata = UserDefaults.standard.getProfileInfo(ProfileData.self, forKey: UserDefaultsKey.profileInfokey.rawValue)
        self.setAllValues()
    }
    
    func setAllValues ()
    {
        self.fatherName.text = profiledata[0].father_husband_name.capitalized
        // self.guardianName.text = profiledata[0].full_name
        self.emailId.text = profiledata[0].email_id.capitalized
        self.watsappNumber.text = profiledata[0].whatsapp_no
        self.phoneNumber.text = profiledata[0].mobile_no
        self.dob.text = profiledata[0].dob
        self.gender.text = profiledata[0].gender.capitalized
        self.religion.text = profiledata[0].religion_name.capitalized
        self.address.text = profiledata[0].address.capitalized
        self.pincode.text = profiledata[0].pin_code
        self.voterId.text = profiledata[0].voter_id_no
        self.adharNumber.text = profiledata[0].aadhaar_no
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

