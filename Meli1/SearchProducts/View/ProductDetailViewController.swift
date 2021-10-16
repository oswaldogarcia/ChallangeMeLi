//
//  ProductDetailViewController.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 14/10/21.
//

import UIKit

class ProductDetailViewController: UIViewController {
    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var attributesView: UIView!
    
    var product : ResultModel = ResultModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setProduct()
        
    }
    
    deinit {
        print("ProductDetailViewController deinit")
    }
    
    
    private func setProduct(){
        
        self.productTitleLabel.text = self.product.title ?? ""
        self.productImage.kf.setImage(with:URL(string: self.product.thumbnail ?? ""))
        self.productPriceLabel.text = self.product.price?.asCurrencyString()
        self.setAttributes()
        
        
    }
    
    private func setAttributes(){
        
        let attributesWidth = Double(self.attributesView.frame.width - 20)
        let attributeHeight = 50.0
        let attributeFrame = CGRect(x: 0.0, y: 0.0, width: (attributesWidth) / 2 , height: attributeHeight)
        
        
        var attributesViews : [UIView] = []
        for (i, attr) in self.product.attributes!.enumerated() {

            let attributeBackgroundColor: UIColor = i % 2 == 0 ? .white : .systemGray6
            
            let attrNameLabel = UILabel(frame: attributeFrame)
            attrNameLabel.backgroundColor = attributeBackgroundColor
            attrNameLabel.text = attr.name ?? ""
            
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
        attributesStack.layer.cornerRadius = 10.0
        self.attributesView.addSubview(attributesStack)
        
       
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
