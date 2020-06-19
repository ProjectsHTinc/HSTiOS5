//
//  PageViewController.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 11/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import Foundation

class PageViewController:UIViewController
{
    
    var strTitle: String!
    var strDiscripition: String!
    var strImageName: String!
    var pageIndex: Int = 0
    
    @IBOutlet var welcomeImage: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var discripitionLabel: UILabel!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.updateUIValues ()
        //self.view.backgroundColor = UIColor.white
    }
        
    func updateUIValues ()
    {
        print(strImageName as Any,strTitle as Any,strDiscripition as Any)
        welcomeImage.image = UIImage(named: strImageName)
        titleLabel.text = strTitle
        discripitionLabel.text = strDiscripition
        if pageIndex == 0
        {
            self.pageControl.currentPage = pageIndex
        }
        else if pageIndex == 1
        {
            self.pageControl.currentPage = pageIndex
        }
        else
        {
            self.pageControl.currentPage = pageIndex
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print("viewWillAppear: \(self.titleLabel!) animated: \(animated)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("viewDidAppear: \(self.titleLabel!) animated: \(animated)")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("viewWillDisappear: \(self.titleLabel!) animated: \(animated)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print("viewDidDisappear: \(self.titleLabel!) animated: \(animated)")
    }
    
    deinit {
        print("deinit: \(self.titleLabel!)")
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

