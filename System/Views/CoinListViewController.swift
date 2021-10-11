//
//  CoinListViewController.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 30.08.2021.
//

import UIKit


//MARK: - CoinListViewController

class CoinListViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var coinListViewTable: UITableView!
    
    let manager = DataManager()
    let listViewCell = ListViewCell()
    let detailVC = CoinDetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        searchBar.delegate = self
        configureTableView()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        searchBar.text = ""
        didFinishUpdating()
        if searchBar.text == "" {
            filteredListViewArray = ListViewArray
        }
    }
    
    @IBAction func favoritesFilterTapped(_ sender: UIButton) {
        if favsViewArray.count == 0 {
            filteredListViewArray = ListViewArray
        } else {
            filteredListViewArray = favsViewArray
        }
        coinListViewTable.reloadData()
    }
    
    func handleFavorites(cell: UITableViewCell) {
        let index = coinListViewTable.indexPath(for: cell)
        let coin = filteredListViewArray[index!.row].id
        
        for each in 0...ListViewArray.count-1 {
            if coin == ListViewArray[each].id {
                if ListViewArray[each].isFavorite == false {
                    ListViewArray[each].isFavorite = true
                } else{
                    ListViewArray[each].isFavorite = false
                }
            }
        }
        
        if filteredListViewArray[index!.row].isFavorite == false {
            filteredListViewArray[index!.row].isFavorite = true
        } else {
            filteredListViewArray[index!.row].isFavorite = false

        }
        coinListViewTable.reloadRows(at: [index!], with: .fade)
    }
    
    func requestDetailData(cell: UITableViewCell) {
        let index = coinListViewTable.indexPath(for: cell)
        let coinRequested = filteredListViewArray[index!.row].id!
        let dataUrl = "\(DetailManager().baseURL)\(coinRequested)"
        
        DetailManager().getDetails(with: dataUrl)
        
    }
}

//MARK: - TABLEVIEW

extension CoinListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(ListViewArray.count)
        print(filteredListViewArray.count)

        return filteredListViewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coinListViewTable.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as! ListViewCell
        
        cell.link = self
        cell.labelOfCell.text = filteredListViewArray[indexPath.row].name
        cell.imageOfCell.downloaded(from: filteredListViewArray[indexPath.row].image!)
        cell.favImage.image = filteredListViewArray[indexPath.row].isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
                
        return cell
        
    }
    
}

    
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
//  TO SHOW FAVORITE STASUS IN TOP100
    func didCheckFavoriteStasus() {
        for item in 0...ListViewArray.count-1 {
            for fav in favsViewArray {
                if fav.id == ListViewArray[item].id {
                    ListViewArray[item].isFavorite = true
                }
            }
        }
    }
}

extension CoinListViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredListViewArray = []
        
        if searchBar.text == "" {
            filteredListViewArray = ListViewArray

        } else {
            
            for coin in ListViewArray {
                if coin.name!.lowercased().contains(searchText.lowercased()) {
                    filteredListViewArray.append(coin)
                }
            }
        }
        coinListViewTable.reloadData()

    }
}
