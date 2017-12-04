//
//  CategoryCollectionModel.swift
//  ProductHunt
//
//  Created by Максим Стегниенко on 03.12.2017.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import Foundation

protocol ICategoryCollectionModel: class {
    weak var delegate: ICategoryCollectionModelDelegate? { get set }
    func fetchTopics()
  
}


protocol ICategoryCollectionModelDelegate: class {
    func setup(categoryModel: [CategoryModel])
}

class CategoryCollectionModel: ICategoryCollectionModel {
    
    weak var delegate: ICategoryCollectionModelDelegate?
    
    let topicsService: ITopicsService
    
    init(topicsService: ITopicsService) {
        self.topicsService = topicsService
    }
    
    func fetchTopics() {
        
        topicsService.loadTopics { (topicsModel, error) in
            
            if let topics = topicsModel {
                self.delegate?.setup(categoryModel: topics )
            }

        }
        
    }

}
