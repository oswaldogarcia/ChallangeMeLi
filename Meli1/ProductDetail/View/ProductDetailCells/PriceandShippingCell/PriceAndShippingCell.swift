//
//  PriceAndShippingCell.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 10/02/22.
//

import UIKit

class PriceAndShippingCell: UITableViewCell {

    
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var creditView: UIView!
    @IBOutlet weak var shippingView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configCell(product: ProductDetailBody){
        
        self.productPriceLabel.text = product.price?.asCurrencyString()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
