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
        
        self.attrNameView.layer.borderWidth = 1
        self.attrNameView.layer.borderColor = UIColor.systemGray5.cgColor
        self.attrNameView.layer.cornerRadius = 5.0
        
        self.attrValueView.layer.borderWidth = 1
        self.attrValueView.layer.borderColor = UIColor.systemGray5.cgColor
        self.attrValueView.layer.cornerRadius = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(attribute: Attribute, row: Int){
        
        self.attrNameLabel.text = attribute.name
        self.attrValueLabel.text = attribute.valueName
        
        self.attrNameView.backgroundColor = row % 2 == 0 ? .white : .systemGray6
        self.attrValueView.backgroundColor = row % 2 == 0 ? .systemGray6 : .white
    }
    
}
