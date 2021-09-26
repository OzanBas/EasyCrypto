//
//  CoinCellTableViewCell.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 31.08.2021.
//

import UIKit

class CoinCell: UITableViewCell {

    @IBOutlet weak var imageOfCell: UIImageView!
    @IBOutlet weak var labelOfCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
