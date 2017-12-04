//
//  TopicsParser.swift
//  ProductHunt
//
//  Created by Максим Стегниенко on 03.12.2017.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import Foundation

class CategoryModel {
    
    var name: String?
    var topicImageUrl: String?
    
}

class TopicsParser: Parser<[CategoryModel]> {
    
    override func parse(data: Data) -> [CategoryModel]? {
        
        do {
            
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else {
                return nil
            }
        
            guard let topics = json["topics"] as? [[String:Any]] else { return nil }
            
            var topicsArray: [CategoryModel] = []
            
            for topic in topics {
                
                let topicModel = CategoryModel()
                
                if let name = topic["name"] as? String {
                    topicModel.name = name
                }
                if let imageUrl = topic["image"] as? String {
        
                    topicModel.topicImageUrl = imageUrl
                }
               
                topicsArray.append(topicModel)
  
            }
            return topicsArray
            
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
        
        
    }
    
}
