//
//  ViewController.swift
//  TableView
//
//  Created by John Lin on 2020-03-31.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MovieCellDelegate {
    
    //MARK: protocol stub
    func movieButtonPressed(at indexPath: IndexPath) {
        //what to do when function is triggered
        switch(indexPath.section) {
        case 0:
            self.resultsLabel.text = liveMovies[indexPath.row]
        case 1:
            self.resultsLabel.text = animatedMovies[indexPath.row]
        default:
            return
        }
    }
    
    
    //MARK: Outlets
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet weak var resultsLabel: UILabel!
    
    
    //MARK: Variables
    let liveMovies = ["Inception", "6 Underground", "Saw"]
    let animatedMovies = ["Frozen", "Frozen II", "Aladdin"]
    let movieGenres = ["Live Action", "Animated"]
    let indexNames = ["L", "A"]
    
    //MARK: Default functions
    //total number of rows in each section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0:
            return liveMovies.count
        case 1:
            return animatedMovies.count
        default:
            return 0
        }
    }
    
    //content in each row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = moviesTableView.dequeueReusableCell(withIdentifier: "movieCell") as? MovieTableViewCell
        
        cell?.movieImage.image = UIImage(named: "icon")
        
        if cell == nil {
            cell = MovieTableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "movieCell")
        }
        
        //setup delegate
        cell?.delegate = self
        cell?.index = indexPath
        
        switch(indexPath.section) {
        case 0:
            cell?.movieNameLabel.text = liveMovies[indexPath.row]
        case 1:
            cell?.movieNameLabel.text = animatedMovies[indexPath.row]
        default:
            return cell!
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let rowSelected = indexPath.row
//        resultsLabel.text = movies[rowSelected]
        switch(indexPath.section) {
        case 0:
            resultsLabel.text = liveMovies[rowSelected]
        case 1:
            resultsLabel.text = animatedMovies[rowSelected]
        default:
            resultsLabel = nil
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return movieGenres[section]
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return indexNames
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.moviesTableView.delegate = self
        self.moviesTableView.dataSource = self
        self.moviesTableView.rowHeight = 150
    }


}

