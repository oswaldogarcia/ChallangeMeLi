//
//  ViewController.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 11/10/21.
//

import UIKit
import RxCocoa
import RxSwift

/// `ProductsListViewController`:
/// This class is the main viewController and have the searh bar to  helps the users
/// to search the product that they wnat , and shows the list of products that the search retunrs

class ProductsListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var productsSearchBar: UISearchBar!
    @IBOutlet weak var productsListTableView: UITableView!
    @IBOutlet weak var logoImage: UIImageView!
    // MARK: - Variables
    var viewModel = ProductsViewModel()
    var disposeBag = DisposeBag()
    var initialNavigationTitle = "Consigue tu producto"
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productsListTableView.delegate = self
        self.registerNib()
        self.bindData()
        self.subscriptionData()
        
        self.title = initialNavigationTitle
    }
    
    func registerNib(){
        // register the ProductListCell
        let cellNib = UINib(nibName:"ProductListCell", bundle: nil)
        productsListTableView.register(cellNib, forCellReuseIdentifier: "ProductListCell")
        productsListTableView.tableFooterView = UIView()
    }
    
    private func bindData(){
        
        /// Bind the data of viewModel.products to productsListTableView to list the product find in the request
        self.viewModel.products
            .bind(to:self.productsListTableView.rx.items(cellIdentifier: "ProductListCell", cellType: ProductListCell.self)){row,product,cell in
                cell.configureCell(product)
            }.disposed(by: self.disposeBag)
        
    }
    
    private func subscriptionData(){
        
        /// Subscribtion of the .editingDidEndOnExit event of
        /// search bar to use the value of productsSearchBar.text
        /// productsSearchBar.text value as string of the query
        /// to search product
        self.productsSearchBar.searchTextField.rx.controlEvent([.editingDidEndOnExit])            .subscribe(onNext: { [weak self] _ in
            let query = self?.productsSearchBar.text ?? ""
            self?.view.endEditing(true)
            
            self?.title = query != "" ? query : self?.initialNavigationTitle
            
            self?.viewModel.query.onNext(query)
            self?.viewModel.paging.onNext(PagingModel())
            if query != "" {
                self?.viewModel.getProducts.onNext(())
            }else{
                self?.viewModel.products.accept([])
            }
            self?.logoImage.isHidden = query != ""
            
        }).disposed(by: self.disposeBag)
        
        /// Subscribtion of the .modelSelected event of
        /// productsListTableView to redirect the user to
        /// ProductDetailViewController and show the detail of the product
        /// selected
        self.productsListTableView.rx.modelSelected(ProductModel.self)
            .subscribe(onNext: { [weak self] product in
                
                let vc = (self?.storyboard?.instantiateViewController(identifier: "ProductDetailViewController"))!  as  ProductDetailViewController
                vc.product = product
                self?.navigationController?.pushViewController(vc , animated: true)
            
        }).disposed(by: self.disposeBag)
        
        /// Pagination of the products list.
        /// Subscribtion of the .didScroll event of
        /// productsListTableView to know when the user is in the
        /// end of the tableView sroll and get more products
        self.productsListTableView.rx.didScroll.subscribe(onNext:{ [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.productsListTableView.contentOffset.y
            let contentHeight = self.productsListTableView.contentSize.height

            if self.viewModel.products.value.count > 0 && offSetY >= (contentHeight - self.productsListTableView.frame.size.height) {
                if !self.viewModel.isCalling.value && !self.viewModel.endOfResults.value{
                    self.viewModel.getProducts.onNext(())
                    self.viewModel.isCalling.accept(true)
                }
            }
        }).disposed(by: self.disposeBag)

        
    
    }
    
}

// MARK: - UITableViewDelegate
extension ProductsListViewController: UITableViewDelegate {
    
    // set height of the cells
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150.00
        
    }
}

