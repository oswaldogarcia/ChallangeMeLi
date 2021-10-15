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
    
    var product : ResultModel = ResultModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setProduct()
    }
    
    
    
    private func setProduct(){
        
        self.productTitleLabel.text = self.product.title ?? ""
        self.productImage.kf.setImage(with:URL(string: self.product.thumbnail ?? ""))
        self.productPriceLabel.text = self.product.price?.asCurrencyString()
        
        
        
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
