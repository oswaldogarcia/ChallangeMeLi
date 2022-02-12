//
//  ProductInformationCell.swift
//  Meli1
//
//  Created by Oswaldo Garcia on 10/02/22.
//

import UIKit
import RxCocoa
import RxSwift

class ProductInformationCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var attributesTableView: UITableView!
    
    // MARK: - Vars
    var attributes : [Attribute] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.attributesTableView.delegate = self
        self.attributesTableView.dataSource = self
        registerNib()
    }
    
    func registerNib(){
        let cellNib = UINib(nibName:"AttributesTableViewCell", bundle: nil)
        attributesTableView.register(cellNib, forCellReuseIdentifier: "AttributesTableViewCell")
        attributesTableView.reloadData()
    }

    
}

// MARK: - UITableViewDelegate - UITableViewDataSource
extension ProductInformationCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.attributes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let attributesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AttributesTableViewCell", for: indexPath) as? AttributesTableViewCell else {return UITableViewCell()}
        let row = indexPath.row
        let attribute = self.attributes[row]
        attributesTableViewCell.configCell(attribute: attribute, row: row , isTheLast: row == self.attributes.count - 1)
        
        return attributesTableViewCell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35
    }
    
}
