//
//  BuyButtonCell.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 10/02/22.
//

import UIKit
import RxSwift
import RxCocoa

class BuyButtonCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    var productUrl = ""
    
    override func awakeFromNib() {
        super.awakeFromNib()
        carButton.layer.cornerRadius = 10
        buyButton.layer.cornerRadius = 10
        
        
    }
    // MARK: - IBActions
    @IBAction func buyButtonAction(_ sender: Any) {
        UIApplication.shared.showAlert("Tu producto fue agregado al carrito y esta listo para ser comprado." ,title: "Ya casi es tuyo!" )
    }
    @IBAction func addCarButtonAction(_ sender: Any) {
        UIApplication.shared.showAlert("Tu producto fue agregado al carrito." ,title: "Ya casi es tuyo!")
    }
    @IBAction func addFovoriteButtonAction(_ sender: Any) {
        
        if self.favoriteButton.imageView?.image == UIImage(systemName: "heart"){
            self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    @IBAction func shareButtonAction(_ sender: Any) {
        self.shareProductUrl()
    }
    func shareProductUrl(){
        
        let textToShare = [self.productUrl]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = UIApplication.shared.keyWindow().rootViewController?.getTopMostViewController()?.view
        
        UIApplication.shared.keyWindow().rootViewController?.getTopMostViewController()?.present(activityViewController, animated: true, completion: nil)
    }
    

    
}
