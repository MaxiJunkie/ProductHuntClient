//
//  ProductListViewController.swift
//  ProductHunt
//
//  Created by Максим Стегниенко on 02.12.2017.
//  Copyright © 2017 Максим Стегниенко. All rights reserved.
//

import UIKit
import Kingfisher

class ProductListViewController: UIViewController {

    @IBOutlet weak var ProductListTableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var model : IProductListModel = ProductListAssembly().initProductListModel()
    
    private var postsArray: [PostsModel] = []
    
    var currentCategory: String = "Tech" {
        didSet {
            updateUI()
        }
    }
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(ProductListViewController.handleRefresh(_:)),
                                          for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.gray
        
        return refreshControl
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *)  {
            self.navigationController?.navigationBar.prefersLargeTitles = true
        }
        self.ProductListTableView.refreshControl = refreshControl
        model.delegate = self
        self.activityIndicator.hidesWhenStopped = true
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        ImageCache.default.clearMemoryCache()
    }
    
    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        fetchPost()
        refreshControl.endRefreshing()
    }

 
    
    // MARK: - Actions

    @IBAction func presentCategoryVC(_ sender: Any) {
        
        let categoryVC = CategoryCollectionAssembly().categoryCollectionViewCotnroller()
        
        self.present(categoryVC, animated: true, completion: nil)
        
    }
    
    // MARK: - Methods
    
    private func updateUI() {
        self.title = "Category " + currentCategory
        self.postsArray.removeAll()
        self.ProductListTableView.reloadData()
        self.activityIndicator.startAnimating()
        fetchPost()
    }
    
    private func fetchPost() {
        var category = currentCategory.replacingOccurrences(of: " ", with: "-")
        category = category.lowercased()
        model.fetchPost(with: category)
    }
    
}


// MARK: - UITableViewDataSource

extension ProductListViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath)
        
        if let postCell = cell as? ProductListTableViewCell {
            postCell.configurePost = postsArray[indexPath.row]
        
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
     
        let productVC = UIStoryboard(name: "Product", bundle: nil).instantiateViewController(withIdentifier: "ProductVC") as! ProductViewController
        productVC.currentPost = self.postsArray[indexPath.row]
        self.navigationController?.pushViewController(productVC, animated: true)
        
    }
    
    
}

// MARK: - UITableViewDelegate

extension ProductListViewController : UITableViewDelegate {
   
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 79
    }
}

extension ProductListViewController: IProductListDelegate {
    
    func setup(dataSource: [PostsModel]) {
        
        self.postsArray = dataSource
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.ProductListTableView.reloadData()
        }
    }
 
}


