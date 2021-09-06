//
//  MeetingTableViewController.swift
//  Constituent
//
//  Created by HappysanziMac on 12/08/21.
//  Copyright © 2021 HappySanzTech. All rights reserved.
//

import UIKit

class MeetingTableViewController: UIViewController {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var requested: UIView!
    @IBOutlet weak var completed: UIView!
    @IBOutlet weak var schedule: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.requested.alpha = 1
        self.schedule.alpha = 0
        self.completed.alpha = 0
        
        self.setUpSegmentControl()
    }
    
    func setUpSegmentControl() {
        segmentedControl.setTitle("Requested", forSegmentAt: 0)
        segmentedControl.setTitle("Scheduled", forSegmentAt: 1)
        segmentedControl.setTitle("Completed", forSegmentAt: 2)
    }
    
    @IBAction func segmentedControlAction(_ sender: Any) {
        
        
        if self.segmentedControl.selectedSegmentIndex == 0 {
            self.requested.alpha = 1
            self.schedule.alpha = 0
            self.completed.alpha = 0
        }
        else if self.segmentedControl.selectedSegmentIndex == 1 {
            self.requested.alpha = 0
            self.schedule.alpha = 1
            self.completed.alpha = 0
        }
        else {
            self.requested.alpha = 0
            self.schedule.alpha = 0
            self.completed.alpha = 1
        }
    }
}
