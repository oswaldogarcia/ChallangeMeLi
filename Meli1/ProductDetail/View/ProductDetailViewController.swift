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
    @IBOutlet weak var attributesTableview: UITableView!
    
    // MARK: - Variables
    var productDetailViewModel = ProductDetailViewModel()
    var disposeBag = DisposeBag()
    var product : ProductModel = ProductModel()
    var attributes =  BehaviorRelay<[Attribute]>(value: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.attributesTableview.delegate = self
        self.registerNib()
        self.bindData()
        self.setProduct()
        self.productDetailViewModel.poductId.onNext(self.product.id ?? "")
        self.productDetailViewModel.getProduct.onNext(())
    }
    
    func registerNib(){
        // register the ProductListCell
        let cellNib = UINib(nibName:"AttributesTableViewCell", bundle: nil)
        attributesTableview.register(cellNib, forCellReuseIdentifier: "AttributesTableViewCell")
        attributesTableview.tableFooterView = UIView()
    }
    
    /// This function set the values of the prduct in the view
    private func setProduct(){
        
        self.productTitleLabel.text = self.product.title ?? ""
        self.productImage.kf.setImage(with:URL(string: self.product.thumbnail ?? ""))
        self.productPriceLabel.text = self.product.price?.asCurrencyString()
        self.attributes.accept(self.product.attributes ?? [])
        //self.setAttributes()
    }
    
    private func bindData(){
        
        /// Bind the data of product.attributes
        self.attributes
            .bind(to:self.attributesTableview.rx.items(cellIdentifier: "AttributesTableViewCell", cellType: AttributesTableViewCell.self)){ [weak self] (row,attribute,cell) in
                cell.configCell(attribute: attribute, row: row , isTheLast: row == ((self?.attributes.value.count ?? 0) - 1))
            }.disposed(by: self.disposeBag)
        
    }
    
    
    /// This function create a Stack view to show the attributes values of the products in the view
   /* private func setAttributes(){
        
        let attributesWidth = Double(self.attributesView.frame.width - 20)
        let attributeHeight = 50.0
        let attributeFrame = CGRect(x: 0.0, y: 0.0, width: (attributesWidth) / 2 , height: attributeHeight)
        
        
        var attributesViews : [UIView] = []
        for (i, attr) in self.product.attributes!.enumerated() {

            let attributeBackgroundColor: UIColor = i % 2 == 0 ? .white : .systemGray6
            
            let attrNameLabel = UILabel(frame: attributeFrame)
            attrNameLabel.backgroundColor = attributeBackgroundColor
            attrNameLabel.text = " \(attr.name ?? ""):"
            
            let attrValueLabel = UILabel(frame: attributeFrame)
            attrValueLabel.backgroundColor = attributeBackgroundColor
            attrValueLabel.text = attr.valueName ?? ""
            
            let attributeStack = UIStackView(arrangedSubviews: [attrNameLabel,attrValueLabel])
            attributeStack.frame = CGRect(x: 0, y: 0, width: attributesWidth , height: attributeHeight)
            attributeStack.axis = .horizontal
            attributeStack.distribution = .fillEqually
            
            attributesViews.append(attributeStack)
        }
        
        let attributesStack = UIStackView(arrangedSubviews: attributesViews)
        
        attributesStack.frame = CGRect(x: 0.0, y: 0.0, width: attributesWidth, height: Double(self.product.attributes!.count) * attributeHeight)
        attributesStack.axis = .vertical
        attributesStack.distribution = .fillEqually
        
        attributesStack.layer.borderWidth = 1.0
        attributesStack.layer.borderColor = UIColor.systemGray5.cgColor
        attributesStack.layer.cornerRadius = 5.0
       
        self.attributesView.addSubview(attributesStack)
        
    }
    */
}
    
    // MARK: - UITableViewDelegate
    extension ProductDetailViewController: UITableViewDelegate {
        
        // set height of the cells
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            
            return 60.00
            
        }
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            
            return 450.00
        }
    }

