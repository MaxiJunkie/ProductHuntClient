//
//  ProductListTableViewCell.swift
//  ProductHunt
//
//  Created by Максим Стегниенко on 02.12.2017.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import UIKit

class ProductListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var imageOfPost: UIImageView!
    @IBOutlet weak var nameOfPost: UILabel!
    @IBOutlet weak var descriptionOfPost: UILabel!
    @IBOutlet weak var numberOfUpvotes: UILabel!
    

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageOfPost?.image = UIImage(named: "placeholder")
    }
    
    
    var configurePost : PostsModel? {
        didSet {
            nameOfPost?.text = configurePost?.name
            descriptionOfPost?.text = configurePost?.description
            if let upvotes = configurePost?.upvotes {
                numberOfUpvotes?.text = "Upvotes \(upvotes)"
            }
            else {
                numberOfUpvotes?.text = "Upvotes 0"
            }
            
            if let thumbnailUrl = configurePost?.thumbnailUrl {
                if let url = URL(string: thumbnailUrl) {
                  
                    imageOfPost.kf.setImage(with: url,
                                            placeholder: UIImage(named: "placeholder"),
                                            options: [.backgroundDecode],
                                            progressBlock: nil,
                                            completionHandler: nil)
 
                }
            }
        }
    }
    
}
