//
//  SearchViewController.swift
//  Trader_Playground
//
//  Created by Ozan Bas on 11.10.2021.
//

import UIKit


class SearchViewController: UIViewController {
    
    @IBOutlet weak var stasusLabel : UILabel!
    @IBOutlet weak var searchTableView : UITableView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
}


extension SearchViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  searchTableView.dequeueReusableCell(withIdentifier: "ListViewCell", for: indexPath) as! ListViewCell
        
        
        return cell
    }
    
    
}
