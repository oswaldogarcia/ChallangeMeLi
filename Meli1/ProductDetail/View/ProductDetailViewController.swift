//
//  ProductDetailViewController.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 14/10/21.
//

import UIKit
import RxCocoa
import RxSwift

/// `ProductDetailViewController`:
/// This class  shows datails of the product selected

class ProductDetailViewController: UIViewController {
    
    
    // MARK: - IBOutlets
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productDetailTableview: UITableView!
    
    // MARK: - Variables
    var productDetailViewModel = ProductDetailViewModel()
    var disposeBag = DisposeBag()
    var product : ProductModel = ProductModel()
    var attributes =  BehaviorRelay<[Attribute]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productDetailTableview.delegate = self
        self.productDetailTableview.dataSource = self
        self.registerNib()
        self.bindData()
        self.productDetailViewModel.poductId.onNext(self.product.id ?? "")
        self.productDetailViewModel.getProduct.onNext(())
    }
    
    func registerNib(){
        /// Title and Pictures Cell nib register
        let titleAndPicturesCellNib = UINib(nibName:"TitleAndPicturesCell", bundle: nil)
        productDetailTableview.register(titleAndPicturesCellNib, forCellReuseIdentifier: "TitleAndPicturesCell")
        /// Price and Shipping Cell nib register
        let priceAndShippingCellNib = UINib(nibName:"PriceAndShippingCell", bundle: nil)
        productDetailTableview.register(priceAndShippingCellNib, forCellReuseIdentifier: "PriceAndShippingCell")
        /// Buy Button Cell  nib register
        let buyButtonCellNib = UINib(nibName:"BuyButtonCell", bundle: nil)
        productDetailTableview.register(buyButtonCellNib, forCellReuseIdentifier: "BuyButtonCell")
        /// Product Information Cell nib register
        let productInformationCellNib = UINib(nibName:"ProductInformationCell", bundle: nil)
        productDetailTableview.register(productInformationCellNib, forCellReuseIdentifier: "ProductInformationCell")
        
        productDetailTableview.tableFooterView = UIView()
    }
    
    
    private func bindData(){
        /// subscribe data of the product detail to load in the table view
        productDetailViewModel.product.subscribe( onNext: { [weak self] (result) in
            self?.productDetailTableview.reloadData()
        }).disposed(by: self.disposeBag)
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        self.productDetailTableview.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        self.productDetailTableview.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        self.productDetailTableview.reloadData()
    }
    
}
    
// MARK: - UITableViewDelegate - UITableViewDataSource
extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0: // Title and pictures
            guard let titleAndPictureCell = tableView.dequeueReusableCell(withIdentifier: "TitleAndPicturesCell", for: indexPath) as? TitleAndPicturesCell else {return UITableViewCell()}
            titleAndPictureCell.configCell(product:productDetailViewModel.product.value)
            return titleAndPictureCell
        case 1:// Price and Shipping
            guard let priceAndShippingCell = tableView.dequeueReusableCell(withIdentifier: "PriceAndShippingCell", for: indexPath) as? PriceAndShippingCell else {return UITableViewCell()}
            priceAndShippingCell.configCell(product:productDetailViewModel.product.value)
            return priceAndShippingCell
        case 2:// Buy buttons
            guard let buyButtonCell = tableView.dequeueReusableCell(withIdentifier: "BuyButtonCell", for: indexPath) as? BuyButtonCell else {return UITableViewCell()}
            buyButtonCell.productUrl = productDetailViewModel.product.value.permalink ?? ""
            return buyButtonCell
        case 3: //Product Information
            guard let productInformationCell = tableView.dequeueReusableCell(withIdentifier: "ProductInformationCell", for: indexPath) as? ProductInformationCell else {return UITableViewCell()}
            productInformationCell.attributes = productDetailViewModel.product.value.attributes ?? []
            productInformationCell.attributesTableView.reloadData()
            return productInformationCell
        default:
            break
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:return 380
        case 1:return 210
        case 2:return 260
        case 3:return CGFloat(((productDetailViewModel.product.value.attributes?.count ?? 0) * 35) + 100)
        default:break
        }
        return 400
    }
    
    
}

