//
//  BattleHistoryViewController.swift
//  Pokedex
//
//  Created by John Lin on 2020-05-25.
//  Copyright © 2020 John Lin. All rights reserved.
//

import UIKit
import CoreData

class BattleHistoryViewController: CommonViewController {

    //MARK: Outlets
    @IBOutlet weak var tvBattleHistory: UITextView!
    
    //MARK: Variables
    let MSG_NO_RECORDS = "No Records Found."
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let request : NSFetchRequest<Battle> = Battle.fetchRequest()
        do {
            let results = try self.db.fetch(request)
            //return to previous if no pokemon to battle
            if (results.count == 0) {
                tvBattleHistory.text = MSG_NO_RECORDS
                return
            }

            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss a"
            
            var output = ""
            for record in results {
                let date = record.date!
                let dateString = dateFormatter.string(from: date as Date)
                let pokemon =
                output += "\(dateString)\t\(record.winningPokemon!.name!) wins\n"
            }
            tvBattleHistory.text = output
        }catch {
            showMessage(message: ERR_UNKNOWN, buttonHandler: { (UIAlertAction) in
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
