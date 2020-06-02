//
//  BattleViewController.swift
//  Pokedex
//
//  Created by John Lin on 2020-05-25.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import CoreData

class BattleViewController: CommonViewController {

    //MARK: Outlets
    
    @IBOutlet weak var tvNamePlayer: UITextView!
    @IBOutlet weak var tvImgPlayer: UIImageView!
    @IBOutlet weak var tvExpPlayer: UITextView!
    @IBOutlet weak var tvNameCpu: UITextView!
    @IBOutlet weak var tvImgCpu: UIImageView!
    @IBOutlet weak var tvExpCpu: UITextView!
    @IBOutlet weak var tvResults: UITextView!
    
    //MARK: Variables
    var playerPokemon: Pokemon?
    var npcPokemon: Pokemon?
    
    let ERR_NO_POKEMON = "There are no other Pokemon to battle"
    let MSG_WINNER = "$\nBattle results saved to database"
    let MSG_WIN_PLAYER = "Player wins!"
    let MSG_WIN_CPU = "Computer wins!"
    let MSG_TIE = "It's a tie!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let request : NSFetchRequest<Pokemon> = Pokemon.fetchRequest()
        if let pokemon = self.playerPokemon {
            request.predicate = NSPredicate(format: "type != %@", pokemon.type!)
            do {
                let results = try self.db.fetch(request)
                //return to previous if no pokemon to battle
                if (results.count == 0) {
                    showMessage(message: ERR_NO_POKEMON, buttonHandler: { (UIAlertAction) in
                        _ = self.navigationController?.popViewController(animated: true)
                        })
                }
                
                //select random pokemon
                self.npcPokemon = results[Int.random(in: results.indices)]
            }
            catch {
                showMessage(message: ERR_NO_POKEMON, buttonHandler: { (UIAlertAction) in
                    _ = self.navigationController?.popViewController(animated: true)
                })
            }

        }else {
            showMessage(message: ERR_UNKNOWN, buttonHandler: { (UIAlertAction) in
                _ = self.navigationController?.popViewController(animated: true)
            })
        }
        initBattle()
        calculateAndSaveResults()
    }
    
    func initBattle() {
        tvNamePlayer.text = self.playerPokemon!.name!
        tvImgPlayer.image = UIImage(named: self.playerPokemon!.photo!)
        tvExpPlayer.text = "\(self.playerPokemon!.baseExpPoints) pts"
        tvNameCpu.text = self.npcPokemon!.name!
        tvImgCpu.image = UIImage(named: self.npcPokemon!.photo!)
        tvExpCpu.text = "\(self.npcPokemon!.baseExpPoints) pts"
    }
    
    func calculateAndSaveResults() {
        if (self.npcPokemon!.baseExpPoints > self.playerPokemon!.baseExpPoints) {
            save(winner: self.npcPokemon!)
            tvResults.text = MSG_WINNER.replacingOccurrences(of: "$", with: MSG_WIN_PLAYER)
        }else if (self.npcPokemon!.baseExpPoints < self.playerPokemon!.baseExpPoints){
            save(winner: self.playerPokemon!)
            tvResults.text = MSG_WINNER.replacingOccurrences(of: "$", with: MSG_WIN_CPU)
        }else {
                save(winner: self.playerPokemon!)
                tvResults.text = MSG_WINNER.replacingOccurrences(of: "$", with: MSG_TIE)
        }
    }
    
    func save(winner: Pokemon) {
//        let date = NSDate()
//        var dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss a"
//        var dateString = dateFormatter.string(from: date as Date)
        
        let battle = Battle(context:self.db)
        battle.winningPokemon = winner
        battle.date = NSDate()
        
        // save to the database
        do {
            try self.db.save()
        }
        catch {
            showMessage(message: ERR_SAVE_FAILED, buttonHandler: { (UIAlertAction) in
                _ = self.navigationController?.popViewController(animated: true)
            })
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
