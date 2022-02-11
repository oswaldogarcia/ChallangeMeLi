//
//  ProductListCell.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 12/10/21.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift

class ProductListCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var installmentsLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var freeShippingLabel: UILabel!
    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        favoriteView.layer.cornerRadius = favoriteView.frame.width / 2
        
        self.favoriteButton.rx.tap.subscribe(onNext: { [weak self] _ in
            
            if self?.favoriteButton.imageView?.image == UIImage(systemName: "suit.heart"){
                self?.favoriteButton.setImage(UIImage(systemName: "suit.heart.fill"), for: .normal)
            }else{
                self?.favoriteButton.setImage(UIImage(systemName: "suit.heart"), for: .normal)
            }
        }).disposed(by: DisposeBag())
    }
    
    func configureCell(_ product:ProductModel){
        
        self.productNameLabel.text = product.title        
        self.productImage.kf.setImage(with:URL(string: product.thumbnail ?? ""))
        self.productPriceLabel.text = product.price?.asCurrencyString()
        self.freeShippingLabel.isHidden = !(product.shipping?.freeShipping ?? false)
        if product.installments?.quantity ?? 0 > 0{
        self.installmentsLabel.text = "en \(product.installments?.quantity ?? 36)x \(Int(product.installments?.amount ?? 0.0).asCurrencyString())"
        }else{
            self.installmentsLabel.isHidden = true
        }
    }

    
    
}
