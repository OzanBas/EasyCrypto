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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coinListViewTable.dataSource = self
        coinListViewTable.register(UINib(nibName: "CoinCell", bundle: nil), forCellReuseIdentifier: "favoritesCell")
        
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        coinListViewTable.delegate = self
        DispatchQueue.main.async {
            self.coinListViewTable.reloadData()
        }

    }
}
    





//MARK: - TableViewDataSource

extension CoinListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        coinModel.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = coinListViewTable.dequeueReusableCell(withIdentifier: "favoritesCell", for: indexPath) as! CoinCell
        
        
        if coinModel[indexPath.row].favorite == true {
            cell.favoriteIcon.image = UIImage(systemName: "star.fill")
            
        } else {
            cell.favoriteIcon.image = UIImage(systemName: "star")
        }
        

        
        cell.labelOfCell.text = coinModel[indexPath.row].coinData.name
        cell.imageOfCell.downloaded(from: coinModel[indexPath.row].coinData.image!)
        
        return cell
        
        
    }
    
}

//MARK: - TableViewDelegate

extension CoinListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        let coin = coinModel[indexPath.row]
                
        if coin.favorite == false {
            coinModel[indexPath.row].favorite = true
        } else if coin.favorite == true {
            coinModel[indexPath.row].favorite = false
        }
        
    }
}


//MARK: - Handling Coin Images

extension UIImageView {
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
