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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            getSelections()
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
        
        cell.nameLabel.text = favsViewArray[indexPath.row].name
        cell.cellImage.downloaded(from: favsViewArray[indexPath.row].image!)
        let price = favsViewArray[indexPath.row].current_price!
        var decimal = 2

        func priceHandler(price : Double) {
            var x = price
            while x*10.0 < 0.99 {
                x = x * 10.0
                decimal += 1
            }
        }
        priceHandler(price: price)
        
        cell.priceLabel.text = "$\(String(format: "%.\(decimal)f", price))"
        
        
        return cell
    }
}
