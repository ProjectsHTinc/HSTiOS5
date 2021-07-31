//
//  NewsDetail.swift
//  Constituent
//
//  Created by Happy Sanz Tech on 19/06/20.
//  Copyright © 2020 HappySanzTech. All rights reserved.
//

import UIKit
import SDWebImage

class NewsDetail: UIViewController {
    
    var newsImage = String()
    var newstitle = String()
    var newsDate = String()
    var newsDetails = String()

    @IBOutlet var bannerImage: UIImageView!
    @IBOutlet var date: UILabel!
    @IBOutlet var titleNews: UILabel!
    @IBOutlet var detailsNews: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.bannerImage.sd_setImage(with: URL(string: newsImage), placeholderImage: UIImage(named: "placeholderNewsfeed.png"))
        self.titleNews.text = newstitle.capitalized
        self.date.text = convertDateFormat(inputDate:newsDate )
        self.detailsNews.attributedText = stringFromHtml(string: newsDetails)
        self.navigationController?.navigationBar.layer.masksToBounds = false
        self.navigationController?.navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.navigationController?.navigationBar.layer.shadowOpacity = 0.5
        self.navigationController?.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 3.0)
        self.navigationController?.navigationBar.layer.shadowRadius = 3
        self.view.isHidden = false
        UINavigationBar.appearance().shadowImage = UIImage()
    }
    
     func stringFromHtml(string: String) -> NSAttributedString? {
        do {
            let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
            if let d = data {
                let str = try NSAttributedString(data: d,
                                                 options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
                                                 documentAttributes: nil)
                return str
            }
        } catch {
        }
        return nil
    }
    
    func convertDateFormat(inputDate: String) -> String {

         let olDateFormatter = DateFormatter()
         olDateFormatter.dateFormat = "dd-MM-yyyy"

         let oldDate = olDateFormatter.date(from: inputDate)

         let convertDateFormatter = DateFormatter()
         convertDateFormatter.dateFormat = "dd MMM"

         return convertDateFormatter.string(from: oldDate!)
    }
}


