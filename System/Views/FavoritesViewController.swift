//
//  ChartViewController.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 30.08.2021.
//

import UIKit


//MARK: - WalletViewController

class FavoritesViewController: UIViewController {
   
    
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet var defaultBGView: UIView!
    @IBOutlet weak var defaultBGLabel: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.register(UINib(nibName: "PriceCell", bundle: nil), forCellReuseIdentifier: "PriceCell")
    }
    
    @IBAction func testButton(_ sender: UIButton) {
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            loadSelections()
            Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(self.constantUpdates), userInfo: nil, repeats: true)
            self.favoritesTableView.reloadData()
        }
    }
    
    var attempPriceUpdate = 0
    @objc private func constantUpdates() {
        priceUpdater()
        attempPriceUpdate += 1
        print(attempPriceUpdate)
        self.favoritesTableView.reloadData()
        
    }

}



//MARK: - TableViewDataSource

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favsViewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath) as! PriceCell
        
        configureCells(for: cell, at: indexPath)
        
        return cell
    }
}

extension FavoritesViewController {
    func configureCells(for cell: PriceCell, at: IndexPath) {
        let price = favsViewArray[at.row].current_price!
        var decimal = 2
        var color : UIColor
        
        func priceHandler(price : Double) {
            var x = price
            while x*10.0 < 0.99 {
                x = x * 10.0
                decimal += 1
            }
        }
        
        func choosePriceColor(_ name: String) -> UIColor{
            switch name {
            case ".red":
                return UIColor(named: "TradeRed")!
            case ".green":
                return UIColor(named: "TradeGreen")!
            default :
                return UIColor(named: "TitleLabel")!
            }
        }
        
        
        func choosePercentageColor() -> UIColor {
            let result = favsViewArray[at.row].price_change_percentage_24h ?? 0.0
            if result > 0 {
                return UIColor(named: "TradeGreen")!
            }
            else if result < 0 {
                return UIColor(named: "TradeRed")!
            } else {
                return UIColor.clear}
        }
        
        
        
        priceHandler(price: price)

        cell.nameLabel.text = "\((favsViewArray[at.row].symbol ?? "null").uppercased())/USD"
        cell.percentageView.backgroundColor = choosePercentageColor()
        cell.percentageLabel.text = "\(String(format: "%.2f", (favsViewArray[at.row].price_change_percentage_24h) ?? 0.0)) %"
        cell.backgroundColor = UIColor(named: "Background")
        cell.priceLabel.text = "\(String(format: "%.\(decimal)f", price))"
        cell.priceLabel.textColor = choosePriceColor(favsViewArray[at.row].priceStasus)
    }
}


extension FavoritesViewController {
}
