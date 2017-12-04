//
//  ProductViewController.swift
//  ProductHunt
//
//  Created by Максим Стегниенко on 04.12.2017.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var currentProductImageView: UIImageView!
    @IBOutlet weak var upvotesLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var currentPost = PostsModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    
    func updateUI() {
        
        self.title = currentPost.name
        
        if let upvotes = currentPost.upvotes {
            upvotesLabel?.text = "Upvotes \(upvotes)"
        }
        else {
            upvotesLabel?.text = "Upvotes 0"
        }
        self.descriptionLabel?.text = currentPost.description
        
        if let thumbnailUrl = currentPost.thumbnailUrl {
            if let url = URL(string: thumbnailUrl) {
                
                currentProductImageView.kf.setImage(with: url,
                                                    placeholder: UIImage(named: "placeholder"),
                                                    options: [.backgroundDecode],
                                                    progressBlock: nil,
                                                    completionHandler: nil)
                
            }
        }
    }
    
    @IBAction func GetItAction(_ sender: UIButton) {
      
        guard let webSiteUrl = self.currentPost.webSiteUrl else {return}
        
        guard let url  = URL(string: webSiteUrl) else {return}
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
        
    }
    

}
