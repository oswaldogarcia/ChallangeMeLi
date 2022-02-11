//
//  AttributesTableViewCell.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 7/02/22.
//

import UIKit

class AttributesTableViewCell: UITableViewCell {

    @IBOutlet weak var attrNameLabel: UILabel!
    @IBOutlet weak var attrValueLabel: UILabel!
    @IBOutlet weak var attrNameView: UIView!
    @IBOutlet weak var attrValueView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.attrNameView.layer.borderWidth = 0.3
        self.attrNameView.layer.borderColor = UIColor.systemGray4.cgColor
        
        
        self.attrValueView.layer.borderWidth = 0.3
        self.attrValueView.layer.borderColor = UIColor.systemGray4.cgColor
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(attribute: Attribute, row: Int, isTheLast:Bool){
        
        self.attrNameLabel.text = "\(attribute.name ?? ""):"
        self.attrValueLabel.text = attribute.valueName
        
        self.attrNameView.backgroundColor = row % 2 == 0 ? .systemGray5 : .systemGray6
        self.attrValueView.backgroundColor = row % 2 == 0 ? .systemGray6 : .white
        
        if row == 0 {
            self.attrNameView.layer.cornerRadius = 5.0
            self.attrNameView.layer.maskedCorners = [.layerMinXMinYCorner]
            self.attrValueView.layer.cornerRadius = 5.0
            self.attrValueView.layer.maskedCorners = [.layerMaxXMinYCorner]
        }
        
        if isTheLast {
            self.attrNameView.layer.cornerRadius = 5.0
            self.attrNameView.layer.maskedCorners = [.layerMinXMaxYCorner]
            self.attrValueView.layer.cornerRadius = 5.0
            self.attrValueView.layer.maskedCorners = [.layerMaxXMaxYCorner]
            
        }
    }
    
}
