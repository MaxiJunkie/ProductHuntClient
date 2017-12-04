//
//  CategoryCollectionAssembly.swift
//  ProductHunt
//
//  Created by Максим Стегниенко on 03.12.2017.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import Foundation


import UIKit

class CategoryCollectionAssembly {
   
    func categoryCollectionViewCotnroller() -> CategoryColectionViewController {
        let model = categoryCollectionModel()
        let categoryCollectionModelVC = CategoryColectionViewController.initCategoryColectionVC(with: model)
        model.delegate = categoryCollectionModelVC
        return categoryCollectionModelVC
    }
    
    // MARK: - PRIVATE SECTION
    
    private func categoryCollectionModel() -> ICategoryCollectionModel {
        return CategoryCollectionModel(topicsService: topicsService())
    }
    
    private func topicsService() -> ITopicsService {
        return TopicsService(requestSender: requestSender())
    }
    
    private func requestSender() -> IRequestSender {
        return RequestSender()
    }
    
}
