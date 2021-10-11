//
//  GainersViewController.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 11.10.2021.
//

import UIKit

class GainersViewController: UIViewController {
    
    
    @IBOutlet weak var gainersTableView: UITableView!
    let manager = DataManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        configureTableView()

        gainersTableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        gainersTableView.reloadData()
    }
    
}



extension GainersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("This much in gainers: \(String(gainersArray.count))")
        return gainersArray.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gainersTableView.dequeueReusableCell(withIdentifier: "PriceCell", for: indexPath) as! PriceCell
        
        configureCells(for: cell, at: indexPath)
        
        return cell
    }
    
    
}

extension GainersViewController {
    func configureCells(for cell: PriceCell, at: IndexPath) {
        let price = gainersArray[at.row].current_price!
        var decimal = 2
        
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
            let result = gainersArray[at.row].price_change_percentage_24h ?? 0.0
            if result > 0 {
                return UIColor(named: "TradeGreen")!
            }
            else if result < 0 {
                return UIColor(named: "TradeRed")!
            } else {
                return UIColor.clear}
        }
        
        
        
        priceHandler(price: price)

        cell.nameLabel.text = "\((gainersArray[at.row].symbol ?? "null").uppercased())/USD"
        cell.percentageView.backgroundColor = choosePercentageColor()
        cell.percentageLabel.text = "\(String(format: "%.2f", (gainersArray[at.row].price_change_percentage_24h) ?? 0.0)) %"
        cell.backgroundColor = UIColor(named: "Background")
        cell.priceLabel.text = "\(String(format: "%.\(decimal)f", price))"
        cell.priceLabel.textColor = choosePriceColor(gainersArray[at.row].priceStasus)
    }
}

extension GainersViewController {
    func configureTableView() {
        
        if ListViewArray.count == 0 {
            manager.getData(with: ListViewApiUrl)
        }
        
        self.gainersTableView.dataSource = self
        self.gainersTableView.register(UINib(nibName: "PriceCell", bundle: nil), forCellReuseIdentifier: "PriceCell")

    }
}

extension GainersViewController: DataManagerDelegate {
    func didFinishUpdating() {
        DispatchQueue.main.async {
            self.gainersTableView.reloadData()
        }
    }
    
    func didCheckFavoriteStasus() {
        ()
    }
}
