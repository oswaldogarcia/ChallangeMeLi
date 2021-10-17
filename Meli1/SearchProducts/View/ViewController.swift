//
//  ViewController.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 11/10/21.
//

import UIKit
import RxCocoa
import RxSwift



class ViewController: UIViewController {
    
    
    @IBOutlet weak var productsSearchBar: UISearchBar!
    @IBOutlet weak var productsListTableView: UITableView!
    @IBOutlet weak var logoImage: UIImageView!
    
   
    var viewModel = ProductsViewModel()
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productsListTableView.delegate = self
        self.registerNib()
        self.bindData()
        self.subscriptionData()
        
        
        self.title = "Consigue tu producto"
    }
    
    deinit {
        print("ViewController deinit")
    }
    
    func registerNib(){
        
        let cellNib = UINib(nibName:"ProductListCell", bundle: nil)
        productsListTableView.register(cellNib, forCellReuseIdentifier: "ProductListCell")
        productsListTableView.tableFooterView = UIView()
    }
    
    private func bindData(){
        
        self.viewModel.products.bind(to:self.productsListTableView.rx.items(cellIdentifier: "ProductListCell", cellType: ProductListCell.self)){row,product,cell in
            cell.configureCell(product)
        }.disposed(by: self.disposeBag)
        
    }
    
    private func subscriptionData(){
        
        self.productsSearchBar.searchTextField.rx.controlEvent([.editingDidEndOnExit])            .subscribe(onNext: { [weak self] _ in
            let query = self?.productsSearchBar.text ?? ""
            self?.view.endEditing(true)
            
            self?.title = query != "" ? query : "Consigue tu producto"
            self?.viewModel.query.accept(query)
            self?.viewModel.searchProduct()
            
            self?.logoImage.isHidden = query != ""
            
        }).disposed(by: self.disposeBag)
        
        
        self.productsListTableView.rx.modelSelected(ResultModel.self)
            .subscribe(onNext: { [weak self] product in
                
                let vc = (self?.storyboard?.instantiateViewController(identifier: "ProductDetailViewController"))!  as  ProductDetailViewController
                vc.product = product
                self?.navigationController?.pushViewController(vc , animated: true)
            
        }).disposed(by: self.disposeBag)
        
        self.productsListTableView.rx.didScroll.subscribe(onNext:{ [weak self] _ in
            guard let self = self else { return }
            let offSetY = self.productsListTableView.contentOffset.y
            let contentHeight = self.productsListTableView.contentSize.height

            if offSetY > (contentHeight - self.productsListTableView.frame.size.height - 100) {
                //self.viewModel.fetchMoreDatas.onNext(())
            }
        }).disposed(by: self.disposeBag)

    }
    
    
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150.00
        
    }
}

