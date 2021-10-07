//
//  CoinDetailViewController.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 30.08.2021.
//

import UIKit


class CoinDetailViewController: UIViewController {
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var coinMarketPosition: UILabel!
    @IBOutlet weak var coinMarketCap: UILabel!
    
    @IBOutlet weak var coinCurrentPrice: UILabel!
    @IBOutlet weak var coin24Highest: UILabel!
    @IBOutlet weak var coin24Lowest: UILabel!
    @IBOutlet weak var coinATH: UILabel!
    @IBOutlet weak var coinCirculation: UILabel!
    @IBOutlet weak var coinMaxSupply: UILabel!
    
    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detailDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "BackToList" {
        let nextView = segue.destination as! UITabBarController
        nextView.selectedIndex = 1
        }
        
    }
    
    @IBAction func backButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "BackToList", sender: self)
    }
}

extension CoinDetailViewController : DetailProtocol {
    func setValues() {
        DispatchQueue.main.async {
            self.coinImage.downloaded(from: detailsReady?.image.large ?? "")

            self.coinMarketPosition.text = "\(detailsReady?.market_cap_rank! ?? 0) #"
            self.coinMarketCap.text = "$\(detailsReady?.market_data.market_cap.usd ?? 0)"

            self.coinCurrentPrice.text = String(detailsReady?.market_data.current_price.usd ?? 0)
            self.coin24Highest.text = String(detailsReady?.market_data.high_24h.usd ?? 0)
            self.coin24Lowest.text = String(detailsReady?.market_data.low_24h.usd ?? 0)
            self.coinATH.text = String(detailsReady?.market_data.ath.usd ?? 0)
            self.coinCirculation.text = String(detailsReady?.market_data.circulating_supply ?? 0)
            self.coinMaxSupply.text = String(detailsReady?.market_data.max_supply ?? 0)

            self.descriptionLabel.text = detailsReady?.description.en
            self.mainLabel.text = detailsReady?.name
        }
    }
}
