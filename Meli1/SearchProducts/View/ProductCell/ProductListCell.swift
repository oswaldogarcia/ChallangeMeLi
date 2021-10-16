//
//  ProductListCell.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 12/10/21.
//

import UIKit
import Kingfisher

class ProductListCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    
    @IBOutlet weak var productPriceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(_ product:ResultModel){
        
        self.productNameLabel.text = product.title        
        self.productImage.kf.setImage(with:URL(string: product.thumbnail ?? ""))
        self.productPriceLabel.text = product.price?.asCurrencyString()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    deinit {
        print("ProductListCell deinit")
    }
    
}
