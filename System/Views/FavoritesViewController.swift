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
        title.self = "Favorites"
        favoritesTableView.dataSource = self
        favoritesTableView.delegate = self
        favoritesTableView.register(UINib(nibName: "PriceCell", bundle: nil), forCellReuseIdentifier: "PriceCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        handleDataArray()
        DispatchQueue.main.async {
            self.favoritesTableView.reloadData()
        }
    }
    
    private func handleDataArray() {
        favsViewArray = ListViewArray.filter{$0.isFavorite == true}
        print(favsViewArray.count)
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
        cell.priceLabel.text = String("$\(favsViewArray[indexPath.row].current_price!)")

        
        
        return cell
    }
}

