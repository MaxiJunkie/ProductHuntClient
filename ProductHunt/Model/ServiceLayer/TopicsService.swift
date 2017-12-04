//
//  TopicsService.swift
//  ProductHunt
//
//  Created by Максим Стегниенко on 03.12.2017.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import Foundation

protocol ITopicsService {
    func loadTopics(completionHandler: @escaping ([CategoryModel]?, String?) -> Void)
}


class TopicsService: ITopicsService {
    
    let requestSender: IRequestSender
    
    init(requestSender: IRequestSender) {
        self.requestSender = requestSender
    }
    
    func loadTopics(completionHandler: @escaping ([CategoryModel]?, String?) -> Void) {
        
        let requestConfig: RequestConfig<[CategoryModel]> = RequestsFactory.ProductHuntTopicsRequest.topicsConfig()
        
        loadImages(requestConfig: requestConfig, completionHandler: completionHandler)
        
    }
    
    
    private func loadImages(requestConfig: RequestConfig<[CategoryModel]>,
                            completionHandler: @escaping ([CategoryModel]?, String?) -> Void) {
        requestSender.send(config: requestConfig) { (result: Result<[CategoryModel]>) in
            
            switch result {
            case .Success(let topics):
                completionHandler(topics, nil)
            case .Fail(let error):
                completionHandler(nil, error)
            }
        }
    }
    
    
}
