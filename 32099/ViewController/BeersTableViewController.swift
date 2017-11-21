//
//  BeersTableViewController.swift
//  32099
//
//  Created by Vinicius Torres on 11/21/17.
//  Copyright © 2017 Vinicius Torres. All rights reserved.
//

import UIKit
import Kingfisher

class BeersTableViewController: UITableViewController {
    
    fileprivate var listBeers = [Beer]()
    fileprivate var selectedBeer: Beer?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "BeerTableViewCell", bundle: nil), forCellReuseIdentifier: "beerCell")

        loadData()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.title = "Lista de Cervejas"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData() {
        
        Service.getBeers(onComplete: { resultBeers in
            
            if let beers = resultBeers {
                DispatchQueue.main.async {
                    self.listBeers = beers
                    
                    if self.listBeers.count < 1 {
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
                        self.tableView.separatorStyle = .singleLine;
                        self.tableView.reloadData()

                    }
                    
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
        return listBeers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beerCell", for: indexPath) as! BeerTableViewCell
        
        let resource = ImageResource(downloadURL: URL(string: listBeers[indexPath.row].image_url!)!, cacheKey: listBeers[indexPath.row].name)
        cell.beerImageIV.kf.setImage(with: resource)
        
        cell.beerNameLbl.text = listBeers[indexPath.row].name
        let abv = listBeers[indexPath.row].abv
        cell.beerABVLbl.text = String(format: "%.1f", abv!)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedBeer = listBeers[indexPath.row]
        performSegue(withIdentifier: "detailsSegue", sender: self)
        
    }

}
