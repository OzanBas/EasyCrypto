//
//  CoinCellTableViewCell.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 31.08.2021.
//

import UIKit


class ListViewCell: UITableViewCell {

    @IBOutlet weak var labelOfCell: UILabel!
    @IBOutlet weak var imageOfCell: UIImageView!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var detailButton: UIButton!
    
    @IBOutlet weak var detailImage: UIImageView!
    
    @IBOutlet weak var favImage: UIImageView!
    
    var link : CoinListViewController?
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        detailButton.addTarget(self, action: #selector(handleGoDetail), for: .touchUpInside)

        favButton.addTarget(self, action: #selector(handleFavoriteStasus), for: .touchUpInside)
    }

    
    @objc private func handleGoDetail() {
        print("want to show details now")
    }
    
    
    @objc private func handleFavoriteStasus() {
        if favImage.image == UIImage(systemName: "star") {
            favImage.image = UIImage(systemName: "star.fill")
        } else {
            favImage.image = UIImage(systemName: "star")
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func favButtonTapped(_ sender: UIButton) {
        link?.tryDelegate(cell: self)
    }
    
    @IBAction func detailButtonTapped(_ sender: UIButton) {
    }
    
}
   


