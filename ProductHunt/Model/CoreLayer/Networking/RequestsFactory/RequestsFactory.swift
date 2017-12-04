//
//  RequestsFactory.swift
//  TinkoffChat
//
//  Created by Максим Стегниенко on 18.11.2017.
//  Copyright © 2017 Maxim Stegnienko. All rights reserved.
//

import Foundation

struct RequestsFactory {
    
    struct ProductHuntPostsRequest {
        
        static func postsConfig(with category: String) -> RequestConfig<[PostsModel]> {
        
            return RequestConfig<[PostsModel]>(request: ProductHuntRequest(category: category), parser: PostsParser())
        }
    
    }
    
    struct ProductHuntTopicsRequest {
        
        static func topicsConfig() -> RequestConfig<[CategoryModel]> {
            
            return RequestConfig<[CategoryModel]>(request: ProductHuntTopicRequest(), parser: TopicsParser())
        }
        
    }
    
}
