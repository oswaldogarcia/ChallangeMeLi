//
//  PriceAndShippingCell.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 10/02/22.
//

import UIKit
import RxCocoa
import RxSwift

class PriceAndShippingCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var creditView: UIView!
    @IBOutlet weak var shippingView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCell(product: ProductDetailBody){
        self.productPriceLabel.text = product.price?.asCurrencyString()
    }
    
    // MARK: - IBActions
    @IBAction func moreInfoAction(_ sender: Any) {
        UIApplication.shared.showAlert("Al pagar con tu TDC podras llevar este producto pagando en hasta 36 cuotas." ,title: "Hasta 36 cuotas!" )
    }
    @IBAction func deliveryButtonAction(_ sender: Any) {
        UIApplication.shared.showAlert("Este producto puede llegar gratis a tu casa, o puedes pasar a retirarlo en tienda." ,title: "Envio Gratis!" )
    }
    
    
}
