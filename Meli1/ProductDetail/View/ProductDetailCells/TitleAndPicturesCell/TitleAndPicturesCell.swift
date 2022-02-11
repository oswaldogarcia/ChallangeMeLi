//
//  TitleAndPicturesCell.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 10/02/22.
//

import UIKit
import Kingfisher

class TitleAndPicturesCell: UITableViewCell {

    @IBOutlet weak var conditionProductLabel: UILabel!
    @IBOutlet weak var titleProductLabel: UILabel!
    @IBOutlet weak var sellerLabel: UILabel!
    @IBOutlet weak var productPicturesView: UIView!
    @IBOutlet weak var productPicturesCollectionView: UICollectionView!
    @IBOutlet weak var counterView: UIView!
    @IBOutlet weak var imagesCounterLabel: UILabel!
    
    var pictures: [Picture]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.productPicturesCollectionView.delegate = self
        self.productPicturesCollectionView.dataSource = self
        let productPictureCellNib = UINib(nibName:"ProductImagesCell", bundle: nil)
        productPicturesCollectionView.register(productPictureCellNib, forCellWithReuseIdentifier: "ProductImagesCell")
        counterView.layer.cornerRadius = 10
    }

    func configCell(product: ProductDetailBody){
        
       conditionProductLabel.text = product.condition == "new" ? "Nuevo" : "Usado"
       titleProductLabel.text = product.title
       pictures = product.pictures
       productPicturesCollectionView.reloadData()
       setCurrentPictureInCounter(index: getCurrentImage())
        
    }
    func setCurrentPictureInCounter(index: Int){
        imagesCounterLabel.text = "\(index) / \(pictures?.count ?? 0)"
    }
    
    func getCurrentImage()->Int{
        
        for cell in productPicturesCollectionView.visibleCells {
            let indexPath = productPicturesCollectionView.indexPath(for: cell)
            
            return (indexPath?.row ?? 1) + 1
            
        }
        
        return 1
        
    }
    
}
extension TitleAndPicturesCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return pictures?.count ?? 0
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductImagesCell", for: indexPath) as? ProductImagesCell else {
             return UICollectionViewCell()
         }
         cell.productImage.kf.setImage(with:URL(string: pictures?[indexPath.row].url ?? ""))
         return cell
     }
    
    func collectionView(_ collectionView: UICollectionView,
                                layout collectionViewLayout: UICollectionViewLayout,
                                sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setCurrentPictureInCounter(index: getCurrentImage())
    }

     
 }
