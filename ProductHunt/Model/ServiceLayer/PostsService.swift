//
//  PostsService.swift
//  ProductHunt
//
//  Created by Максим Стегниенко on 02.12.2017.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import Foundation

protocol IPostsService {
    func loadNewPosts(with category: String,completionHandler: @escaping ([PostsModel]?, String?) -> Void)
}


class PostsService: IPostsService {
    
    let requestSender: IRequestSender
    
    init(requestSender: IRequestSender) {
        self.requestSender = requestSender
    }
    
    func loadNewPosts(with category: String ,completionHandler: @escaping ([PostsModel]?, String?) -> Void) {
        
        let requestConfig: RequestConfig<[PostsModel]> = RequestsFactory.ProductHuntPostsRequest.postsConfig(with: category)
        
        loadImages(requestConfig: requestConfig, completionHandler: completionHandler)
    }

    
    private func loadImages(requestConfig: RequestConfig<[PostsModel]>,
                            completionHandler: @escaping ([PostsModel]?, String?) -> Void) {
        requestSender.send(config: requestConfig) { (result: Result<[PostsModel]>) in
            
            switch result {
            case .Success(let posts):
                completionHandler(posts, nil)
            case .Fail(let error):
                completionHandler(nil, error)
            }
        }
    }
    

    
}
