//
//  ProductHuntPostsRequest.swift
//  TinkoffChat
//
//  Created by Максим Стегниенко on 18.11.2017.
//  Copyright © 2017 Maxim Stegnienko. All rights reserved.
//

import Foundation

class ProductHuntRequest: IRequest {
    
    private let baseUrl: String = "https://api.producthunt.com/"
    
    private let searchType: String = "v1/posts/all?search[category]="
    
    private let accessToken: String = "Bearer 591f99547f569b05ba7d8777e2e0824eea16c440292cce1f8dfb3952cc9937ff"
    
    private let category: String
    
    private let contentType: String = "application/json"
    
    private let accept: String = "application/json"
    
    // MARK: - IRequest
    
    var urlRequest: URLRequest? {

        let urlString: String = baseUrl + searchType + category
        
        if let url = URL(string: urlString) {
            var urlRequest = URLRequest(url: url)
            
            urlRequest.addValue(accessToken, forHTTPHeaderField: "Authorization")
            urlRequest.addValue(contentType, forHTTPHeaderField: "Content-Type")
            urlRequest.addValue(accept, forHTTPHeaderField: "Accept")
            
            return urlRequest
        }
        return nil
    }
    
    // MARK: - Initialization
    
    init(category: String ) {
        self.category = category
    }
    
    
}
