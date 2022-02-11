//
//  BuyButtonCell.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 10/02/22.
//

import UIKit

class BuyButtonCell: UITableViewCell {

    @IBOutlet weak var carButton: UIButton!
    @IBOutlet weak var buyButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        carButton.layer.cornerRadius = 10
        buyButton.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
