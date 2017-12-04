//
//  ProductListModel.swift
//  ProductHunt
//
//  Created by Максим Стегниенко on 02.12.2017.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import Foundation

protocol IProductListModel: class {
    weak var delegate: IProductListDelegate? { get set }
    func fetchPost(with category: String)
}

protocol IProductListDelegate: class {
    func setup(dataSource: [PostsModel])
}



class ProductListModel: IProductListModel {
    
    var  delegate: IProductListDelegate?
    
    let postsService: IPostsService
    
    init(postsService: IPostsService) {
        self.postsService = postsService
    }
    
    
    func fetchPost(with category: String) {
        
        postsService.loadNewPosts(with: category) { (postsArray, error) in
          
            if let posts = postsArray {
                self.delegate?.setup(dataSource: posts )
            }
        }
      
    }
    
}
