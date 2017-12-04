//
//  ImagesParser.swift
//  TinkoffChat
//
//  Created by Максим Стегниенко on 18.11.2017.
//  Copyright © 2017 Maxim Stegnienko. All rights reserved.
//

import Foundation

class PostsModel  {

    var thumbnailUrl: String?
    var name: String?
    var upvotes: Int?
    var description: String?
    var webSiteUrl: String?
    
}


class PostsParser: Parser<[PostsModel]> {
    
    override func parse(data: Data) -> [PostsModel]? {
       
        do {
            
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                return nil
            }
      
            guard let posts = json["posts"] as? [[String:Any]] else { return nil }
       
            var postsArray: [PostsModel] = []
        
            for post in posts {
    
                let postModel = PostsModel()
          
                if let name = post["name"] as? String {
                    postModel.name = name
                }
                if let description = post["tagline"] as? String {
                    postModel.description = description
                }
                if let upvotes = post["votes_count"] as? Int {
                    postModel.upvotes = upvotes
                }
                if let thumbnailDictionary = post["thumbnail"] as? [String:Any] {
                    if let thumbnailUrl = thumbnailDictionary["image_url"] as? String {
                        let removeString = "?auto=format&fit=crop&h=570&w=430"
                        let truncated = String(thumbnailUrl.dropLast(removeString.count))
                        postModel.thumbnailUrl = truncated
                    }
                }
                if let webSiteUrl = post["redirect_url"] as? String {
                    postModel.webSiteUrl = webSiteUrl
                }
            
                postsArray.append(postModel)
            }
            
            return postsArray
            
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
 
 
    }
    
}
