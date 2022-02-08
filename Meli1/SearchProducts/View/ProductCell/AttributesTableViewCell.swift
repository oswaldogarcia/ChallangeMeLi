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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(attribute: Attribute){
        
        self.attrNameLabel.text = attribute.name
        self.attrValueLabel.text = attribute.valueName
    }
    
}
