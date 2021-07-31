//
//  ViewController.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 11/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import EMPageViewController

class WelcomeScreen: UIViewController, EMPageViewControllerDataSource, EMPageViewControllerDelegate  {

    var screenIndex: Int = 0
    @IBOutlet var nextOutlet: UIButton!
    @IBOutlet var skipOutlet: UIButton!
    
    var strpageViewController: EMPageViewController?
    var welcomeScreenImages: [String] = ["welcomescreenimgOne", "welcomescreenimgTwo", "welcomescreenimgThree"]
    var welcomeScreenTitle: [String] = ["Grievance", "Constituency", "Stay Connect"]
    var welcomeScreenDiscripition: [String] = ["Resolve constituents' complaints", "See more content related to constituency", "Stay in touch with your local representative!"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        /*Setup PageviewController*/
        self.setupPageViewController()
    }
        
    func setupPageViewController()
    {
        self.view.backgroundColor = UIColor.white
        let strpageViewController = EMPageViewController()
        // Or, for a vertical orientation
        // let pageViewController = EMPageViewController(navigationOrientation: .Vertical)
        strpageViewController.dataSource = self
        strpageViewController.delegate = self
        // Set the initially selected view controller
        // IMPORTANT: If you are using a dataSource, make sure you set it BEFORE calling selectViewController:direction:animated:completion
        let currentViewController = self.viewController(at: 0)!
        strpageViewController.selectViewController(currentViewController, direction: .forward, animated: false, completion: nil)
        // Add EMPageViewController to the root view controller
        self.addChild(strpageViewController)
        self.view.insertSubview(strpageViewController.view, at: 0) // Insert the page controller view below the navigation buttons
        strpageViewController.didMove(toParent: self)
        self.strpageViewController = strpageViewController
    }
    
    @IBAction func nextAction(_ sender: Any)
    {
        if self.screenIndex == 3
        {
            self.performSegue(withIdentifier: "to_Login", sender: self)
        }
        else
        {
            self.strpageViewController!.scrollForward(animated: true, completion: nil)
        }
    }
    
    @IBAction func skipAction(_ sender: Any)
    {
        self.performSegue(withIdentifier: "to_Login", sender: self)
    }
    
        // MARK: - EMPageViewController Data Source
        
    func em_pageViewController(_ pageViewController: EMPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.index(of: viewController as! PageViewController) {
            let beforeViewController = self.viewController(at: viewControllerIndex - 1)
            return beforeViewController
        } else {
            return nil
        }
    }
    
    func em_pageViewController(_ pageViewController: EMPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.index(of: viewController as! PageViewController) {
            let afterViewController = self.viewController(at: viewControllerIndex + 1)
            return afterViewController
        } else {
            return nil
        }
    }
    
    func viewController(at index: Int) -> PageViewController? {
        if (self.welcomeScreenTitle.count == 0) || (index < 0) || (index >= self.welcomeScreenTitle.count) {
            return nil
        }
        
        let viewController = self.storyboard!.instantiateViewController(withIdentifier: "pageViewController") as! PageViewController
        viewController.strTitle = self.welcomeScreenTitle[index]
        viewController.strDiscripition = self.welcomeScreenDiscripition[index]
        viewController.strImageName = self.welcomeScreenImages[index]
        viewController.pageIndex = index
        return viewController
    }
    
    func index(of viewController: PageViewController) -> Int? {
        if let welcometitle: String = viewController.strTitle {
            return self.welcomeScreenTitle.firstIndex(of: welcometitle)
        } else {
            return nil
        }
    }
    
    // MARK: - EMPageViewController Delegate

    func em_pageViewController(_ pageViewController: EMPageViewController, willStartScrollingFrom startViewController: UIViewController, destinationViewController: UIViewController) {
        
        let startGreetingViewController = startViewController as! PageViewController
        let destinationGreetingViewController = destinationViewController as! PageViewController
        
        print("Will start scrolling from \(startGreetingViewController.strTitle!) to \(destinationGreetingViewController.strTitle!).")
    }
    
    func em_pageViewController(_ pageViewController: EMPageViewController, isScrollingFrom startViewController: UIViewController, destinationViewController: UIViewController, progress: CGFloat) {
        let startGreetingViewController = startViewController as! PageViewController
        let destinationGreetingViewController = destinationViewController as! PageViewController
        
        // Ease the labels' alphas in and out
        let absoluteProgress = abs(progress)
        startGreetingViewController.titleLabel.alpha = pow(1 - absoluteProgress, 2)
        destinationGreetingViewController.titleLabel.alpha = pow(absoluteProgress, 2)
        
       print("Is scrolling from \(startGreetingViewController.strTitle!) to \(destinationGreetingViewController.strTitle!) with progress '\(progress)'.")
    }
    
    func em_pageViewController(_ pageViewController: EMPageViewController, didFinishScrollingFrom startViewController: UIViewController?, destinationViewController: UIViewController, transitionSuccessful: Bool) {
        let startViewController = startViewController as! PageViewController?
        let destinationViewController = destinationViewController as! PageViewController
        
        // If the transition is successful, the new selected view controller is the destination view controller.
        // If it wasn't successful, the selected view controller is the start view controller
        if transitionSuccessful {
            
            if (self.index(of: destinationViewController) == 0) {
            } else {
            }
            
            if (self.index(of: destinationViewController) == self.welcomeScreenTitle.count - 1) {
                self.skipOutlet.isHidden = true
                self.nextOutlet.setTitle("Get Started", for: .normal)
                self.screenIndex = 3

            } else {
                self.skipOutlet.isHidden = false
                self.nextOutlet.setTitle("Next", for: .normal)
                self.screenIndex = 0
            }
        }
        
        print("Finished scrolling from \(startViewController != nil ? startViewController!.strTitle! : "nil") to \(destinationViewController.strTitle!). Transition successful? \(transitionSuccessful)")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "to_Login")
        {
            let _ = segue.destination as! Login
        }
    }
}


