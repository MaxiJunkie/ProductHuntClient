//
//  ProductListAssembly.swift
//  ProductHunt
//
//  Created by Максим Стегниенко on 02.12.2017.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import Foundation


class ProductListAssembly {
    
    func initProductListModel() -> IProductListModel {
        
        let model: IProductListModel = productListModel()

        return model
    }
    
 
    // MARK: - PRIVATE SECTION
    
    private func productListModel() -> IProductListModel {
        return ProductListModel(postsService: postsService())
    }
    
    private func postsService() -> IPostsService {
        return PostsService(requestSender: requestSender())
    }
    
    private func requestSender() -> IRequestSender {
        return RequestSender()
    }
    
        
}
