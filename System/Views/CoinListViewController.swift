//
//  CoinListViewController.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 30.08.2021.
//

import UIKit



//MARK: - CoinListViewController

class CoinListViewController: UIViewController {

    
    @IBOutlet weak var coinListViewTable: UITableView!
    
    let ListViewApiUrl = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false"
    let manager = DataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        configureTableView()
        didFinishUpdating()

    }
}
extension CoinListViewController {
    func configureTableView() {
        if ListViewArray.count == 0 {
            manager.getData(with: ListViewApiUrl)
        }
        self.coinListViewTable.dataSource = self
        self.coinListViewTable.register(UINib(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "favoritesCell")
    }
}


//MARK: - TableViewDataSource

extension CoinListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ListViewArray.count)
        return ListViewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coinListViewTable.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as! CoinCell
        
        cell.labelOfCell.text = ListViewArray[indexPath.row].name
        cell.imageOfCell.downloaded(from: ListViewArray[indexPath.row].image!)
                
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}


extension CoinListViewController: DataManagerDelegate {
    func didFinishUpdating() {
        DispatchQueue.main.async {
            self.coinListViewTable.reloadData()

        }
    }
}

