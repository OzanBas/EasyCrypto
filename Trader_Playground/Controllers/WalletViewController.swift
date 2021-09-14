//
//  ChartViewController.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 30.08.2021.
//

import UIKit


//MARK: - WalletViewController

class WalletViewController: UIViewController {
   
    
    @IBOutlet weak var favoritesTableView: UITableView!
    @IBOutlet var defaultBGView: UIView!
    @IBOutlet weak var defaultBGLabel: UILabel!
    
    var dataManager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        favoritesTableView.dataSource = self
        favoritesTableView.register(UINib(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "favoritesCell")
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        DispatchQueue.main.async {
            self.favoritesTableView.reloadData()
        }

        starterGuide()
    }
    
    
    func starterGuide() {
        let gemsFiltered = coinModel.filter {$0.favorite == true}
        if gemsFiltered.count == 0 {
            defaultBGLabel.text = "Add items from Assets List"
            favoritesTableView.backgroundView = defaultBGView
        } else if gemsFiltered.count > 0 {
            defaultBGLabel.text = ""
        }
    }

    
    
}
//MARK: - TableViewDataSource

extension WalletViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let filtered = coinModel.filter {$0.favorite == true}
        return filtered.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favoritesTableView.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as! CoinCell
        setValues(cell: cell, indexPath: indexPath)
        
        return cell
    }
}


extension WalletViewController {
    func setValues(cell: CoinCell, indexPath: IndexPath) {
        let filtered = coinModel.filter {$0.favorite == true}
        if let price = filtered[indexPath.row].coinData.current_price {
            let formattedPrice = String(format: "%.2f", price)
            cell.priceLabel.text = "$\(formattedPrice)"
            cell.priceLabel.textColor = .black
        }
        
        
        cell.labelOfCell.text = filtered[indexPath.row].coinData.name
        cell.imageOfCell.downloaded(from: filtered[indexPath.row].coinData.image!)

    }
}
