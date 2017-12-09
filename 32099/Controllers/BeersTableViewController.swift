//
//  BeersTableViewController.swift
//  32099
//
//  Created by Vinicius Torres on 11/21/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit

class BeersTableViewController: UITableViewController {
    
    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    fileprivate var listBeers = BeerManager()
    fileprivate var selectedBeer: Beer?
    fileprivate var currentPage = 1
    fileprivate var hasNext = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "BeerTableViewCell", bundle: nil), forCellReuseIdentifier: "beerCell")
        
        activityIndicator.color = .black
        activityIndicator.hidesWhenStopped = true
        
        self.tableView.backgroundView = activityIndicator;
        self.tableView.separatorStyle = .none;

        loadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = "Lista de Cervejas"
    }
    
    func loadData() {
        
        let currentCount = listBeers.returnBeersCount()
        
        activityIndicator.startAnimating()
        
        listBeers.downloadBeersList(page: currentPage, onComplete: { (result) in
            if result {
                DispatchQueue.main.async {
                    if self.listBeers.returnBeersCount() < 1 {
                        
                        self.activityIndicator.removeFromSuperview()
                        
                        let message = "Nenhuma cerveja encontrada."
                        let messageLabel = UILabel(frame: CGRect(x: 0,y: 0,width: self.view.bounds.size.width, height:  self.view.bounds.size.height))
                        messageLabel.text = message
                        messageLabel.textColor = UIColor.black
                        messageLabel.numberOfLines = 0;
                        messageLabel.textAlignment = .center;
                        messageLabel.sizeToFit()
                        
                        self.tableView.backgroundView = messageLabel;
                        self.tableView.separatorStyle = .none;
                    } else {
                        self.activityIndicator.removeFromSuperview()
                        
                        self.tableView.separatorStyle = .singleLine;
                        
                        if currentCount == self.listBeers.returnBeersCount() {
                            self.hasNext = false
                        }
                        
                        self.tableView.reloadData()
                        
                    }
                }
            } else {
                DispatchQueue.main.async {
                    
                    self.activityIndicator.removeFromSuperview()

                    let message = "Falha ao baixar dados."
                    let messageLabel = UILabel(frame: CGRect(x: 0,y: 0,width: self.view.bounds.size.width, height:  self.view.bounds.size.height))
                    messageLabel.text = message
                    messageLabel.textColor = UIColor.black
                    messageLabel.numberOfLines = 0;
                    messageLabel.textAlignment = .center;
                    messageLabel.sizeToFit()
                    
                    self.tableView.backgroundView = messageLabel;
                    self.tableView.separatorStyle = .none;
                }
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailsSegue" {
            let detailsVC = segue.destination as! DetailsViewController
            self.title = ""
            detailsVC.beer = self.selectedBeer
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBeers.returnBeersCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! BeerTableViewCell
        let beer = listBeers.getBeerAtIndex(index: indexPath.row)
        cell.prepare(beer: beer)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedBeer = listBeers.getBeerAtIndex(index: indexPath.row)
        performSegue(withIdentifier: "detailsSegue", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 >= listBeers.returnBeersCount() && hasNext{
            self.currentPage += 1
            self.loadData()
        }
    }

}
