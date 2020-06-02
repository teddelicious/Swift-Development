//
//  PokedexTableViewController.swift
//  Pokedex
//
//  Created by John Lin on 2020-05-24.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import CoreData

class PokedexTableViewController: UITableViewController, PokemonCellDelegate {
    
    //MARK: Variables
    var pokedex: [Pokemon] = [Pokemon]()
    var selectedPokemon: Pokemon?
    
    //MARK: Functions & helper
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        self.selectedPokemon = nil
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.pokedex.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pokemonRowSelected(index: indexPath.row)
        return
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonCell", for: indexPath) as? PokemonTableViewCell
         //Configure the cell...
        let row = indexPath.row
        let img = "\(self.pokedex[row].photo!).png"
        cell?.imgPokemon.image = UIImage(named: img)
        print(img)
        cell?.imgType.image = UIImage(named: "\(self.pokedex[row].type!).png")
        cell?.tvName.text = self.pokedex[row].name
        cell?.tvBaseExp.text = String(self.pokedex[row].baseExpPoints)
        
        //setup delegate
        cell?.delegate = self
        cell?.index = indexPath
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "battleSegue" {
            if let vc = segue.destination as? BattleViewController {
                vc.playerPokemon = self.selectedPokemon
            }
        }
    }
    
    func pokemonRowSelected(index: Int) {
        //what to do when function is triggered
        print(index)
        let box = UIAlertController(title: "Battle Confirmation", message: "Proceed to battle using \(self.pokedex[index].name!)", preferredStyle: .alert)
        box.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        box.addAction(UIAlertAction(title: "Yes", style: .default, handler: {
            action in
            self.selectedPokemon = self.pokedex[index]
            self.performSegue(withIdentifier: "battleSegue", sender: self)
        }))
        self.present(box, animated: true, completion: nil)
    }

    func fetchData() {
        let db = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request : NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        let sd = NSSortDescriptor(key: #keyPath(Pokemon.name), ascending: true)
        request.sortDescriptors = [sd]

        do {
            let results = try db.fetch(request)
            if results.count == 0 {
                print("no results found")
            }
            else {
                self.pokedex = results
                // print each user
                for pokemon in results {
                    print(pokemon.name)
                }
            }
        }catch {
            print("error")
        }
    }
}
