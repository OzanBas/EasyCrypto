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
    let listViewCell = ListViewCell()
    

    func handleFavorites(cell: UITableViewCell) {
        let index = coinListViewTable.indexPath(for: cell)
        print(ListViewArray[index!.row].isFavorite)

        if ListViewArray[index!.row].isFavorite == false {
            ListViewArray[index!.row].isFavorite = true
        } else {
            ListViewArray[index!.row].isFavorite = false
        }
        coinListViewTable.reloadRows(at: [index!], with: .fade)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title.self = "Top 100"
        manager.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        configureTableView()
        didFinishUpdating()
    }
}

//MARK: - TABLEVIEW RELATED SECTION

extension CoinListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ListViewArray.count)
        return ListViewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coinListViewTable.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as! ListViewCell
        
        cell.link = self
        cell.labelOfCell.text = ListViewArray[indexPath.row].name
        cell.imageOfCell.downloaded(from: ListViewArray[indexPath.row].image!)
        cell.favImage.image = ListViewArray[indexPath.row].isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
                
        return cell
        
    }
}

//MARK: - ConfigureTableView
    
extension CoinListViewController {
    func configureTableView() {
        if ListViewArray.count == 0 {
            manager.getData(with: ListViewApiUrl)
        }
        self.coinListViewTable.dataSource = self
        self.coinListViewTable.register(UINib(nibName: "ListViewCell", bundle: nil), forCellReuseIdentifier: "ListViewCell")
    }
}


//MARK: - DataManagerDelegate
extension CoinListViewController: DataManagerDelegate {
    func didFinishUpdating() {
        DispatchQueue.main.async {
            self.coinListViewTable.reloadData()

        }
    }
}

