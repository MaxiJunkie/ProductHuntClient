//
//  CategoryColectionViewController.swift
//  ProductHunt
//
//  Created by Максим Стегниенко on 03.12.2017.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import Foundation
import UIKit

class CategoryColectionViewController: UIViewController {
    
    
    @IBOutlet weak var categoryCollectionViewController: UICollectionView!
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 15.0, right: 20.0)
    
    var topics: [CategoryModel] = []
    
    var categoryCollectionModel: ICategoryCollectionModel!
    
    static func initCategoryColectionVC(with model: ICategoryCollectionModel) -> CategoryColectionViewController {
        let categoryVC = UIStoryboard(name: "CategoryVC", bundle: nil).instantiateViewController(withIdentifier: "categoryViewController") as! CategoryColectionViewController
        categoryVC.categoryCollectionModel = model
        return categoryVC
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *)  {
            self.navigationBar.prefersLargeTitles = true
        }
        self.categoryCollectionViewController.dataSource = self
        self.categoryCollectionViewController.delegate = self
        
        categoryCollectionModel.fetchTopics()
        
    }
    
    @IBAction func cancelButton(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension CategoryColectionViewController: UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.topics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath)
        
        
        if let categoryCell = cell as? CategoryCollectionViewCell {
            categoryCell.categoryName?.text = topics[indexPath.row].name
            
            if let topicImageUrl = topics[indexPath.row].topicImageUrl {
                if let url = URL(string: topicImageUrl) {
                    
                    categoryCell.categoryImageView.kf.setImage(with: url,
                                            placeholder: UIImage(named: "placeholder"),
                                            options: [.backgroundDecode],
                                            progressBlock: nil,
                                            completionHandler: nil)
                    
                }
            }
            
        }
            
        return cell
    }
    
}

extension CategoryColectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }
    
    
}

extension CategoryColectionViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        collectionView.deselectItem(at: indexPath, animated: true)
      
        if let presenting = presentingViewController as? UINavigationController {
            
            if let rootViewController = presenting.topViewController as? ProductListViewController {
                if let name = self.topics[indexPath.row].name {
                    rootViewController.currentCategory = name
                    self.dismiss(animated: true, completion: nil)
                }
            }
        }
    }
}

extension CategoryColectionViewController:  ICategoryCollectionModelDelegate {
  
    func setup(categoryModel: [CategoryModel]) {
   
        self.topics = categoryModel
        DispatchQueue.main.async {
            self.categoryCollectionViewController.reloadData()
        }
        
    }
    
}
