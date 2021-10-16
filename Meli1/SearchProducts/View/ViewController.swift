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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var products = BehaviorRelay<[ResultModel]>(value: [])
    var disposeBag = DisposeBag()
    var viewModel = ProductsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productsListTableView.delegate = self
        self.registerNib()
        self.bindData()
        self.subscriptionData()
        self.activityIndicatorActive(false)
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
        
        self.products.bind(to:self.productsListTableView.rx.items(cellIdentifier: "ProductListCell", cellType: ProductListCell.self)){row,product,cell in
            cell.configureCell(product)
        }.disposed(by: self.disposeBag)
        
    }
    
    private func subscriptionData(){
        
        self.productsSearchBar.searchTextField.rx.controlEvent([.editingDidEndOnExit])            .subscribe(onNext: { [weak self] _ in
            let query = self?.productsSearchBar.text ?? ""
            self?.view.endEditing(true)
            self?.products.accept([])
            if query != ""{
                self?.activityIndicatorActive(true)
                self?.getProducts(query)
            }
        }).disposed(by: self.disposeBag)
        
        self.productsListTableView.rx.modelSelected(ResultModel.self)
            .subscribe(onNext: { [weak self] product in
                
                let vc = (self?.storyboard?.instantiateViewController(identifier: "ProductDetailViewController"))!  as  ProductDetailViewController
                vc.product = product
                self?.navigationController?.pushViewController(vc , animated: true)
            
        }).disposed(by: self.disposeBag)

    }
    
    
    
    private func getProducts(_ query:String){
        self.viewModel.getProducts(query).subscribe( onNext: { [weak self] (products) in
            self?.products.accept(products)
            self?.activityIndicatorActive(false)
        }).disposed(by: self.disposeBag)
    }
    
    private func activityIndicatorActive(_ active: Bool){
        if active {
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        }else{
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()
        }
        
        
    }
    
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 150.00
        
    }
}

