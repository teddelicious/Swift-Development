//
//  ViewController.swift
//  DictionaryApp
//
//  Created by Parrot on 2020-05-09.
//  Copyright © 2020 Parrot. All rights reserved.
//

import UIKit

// Setup this file with TableView delegates
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // Outlets
    @IBOutlet weak var textboxWord: UITextField!
    @IBOutlet weak var textboxTranslation: UITextField!

    @IBOutlet weak var tableView: UITableView!

    // Data source
    // - need to define a struct with codable
    var words:[EnglishWord] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // setup tableview delegates and datasource
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // load the json file here
        guard let file = openFile() else { return }
        
        // load words from file into data source
        words = self.getData(from: file)!
    }

    // ---------------------------
    // MARK: Helper Functions for File handling
    // ---------------------------
    func openDefaultFile()-> String? {
        
        guard let file = Bundle.main.path(forResource:"EmployeeList.json", ofType:"json") else {
            print("Cannot find file")
            return nil;
        }
        print("File found: \(file.description)")
        return file
    }
    
    
    func openFile() -> String? {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let finalPath = paths[0]
        
        let filename = finalPath.appendingPathComponent("EmployeeList.json")
        
        // check if file exists
        let fileExists = FileManager().fileExists(atPath: filename.path)
        
        if (fileExists == true) {
            // load words from saved file
            return filename.path;
        }
        else {
            // open words from default file
            return self.openDefaultFile()
        }
        return nil
    }
    
    func getData(from file:String?) -> [EnglishWord]? {
        if (file == nil) {
            print("File path is null")
            return nil
        }
        
        do {
            // open the file
            let jsonData = try String(contentsOfFile: file!).data(using: .utf8)
            print(jsonData)         // outputs: Optional(749Bytes)
            
            // get content of file
            let decodedData =
                try JSONDecoder().decode([EnglishWord].self, from: jsonData!)
            
            // DEBUG: print file contents to screen
            dump(decodedData)
            
            return decodedData
        } catch {
            print("Error while parsing file")
            print(error.localizedDescription)
        }
        return nil
    }
    
    // ---------------------------
    // MARK: TableView functions
    // ---------------------------
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // detect when row is clicked
        
        // Show word in console
        let i = indexPath.row
        print("Selected item: \(words[i].translation)")
        
        // Display word in action sheet
        let alert = UIAlertController(title: "Translation", message: "\(words[i].translation)", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default , handler:nil))

        self.present(alert, animated: true, completion:nil)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // set number of items in table view
        return self.words.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        
        let i = indexPath.row
        cell.textLabel?.text = "\(self.words[i].word)"
        return cell
    }
    
    // ---------------------------
    // MARK: Actions
    // ---------------------------
    @IBAction func addWordTapped(_ sender: Any) {
        guard let word = textboxWord.text else {
            return
        }
        guard let trans = textboxTranslation.text else {
            return
        }
        
        if (word.isEmpty || trans.isEmpty) {
            print("Textboxes are empty")
            return
        }
        
        // ----
        var englishWord:EnglishWord = EnglishWord()
        englishWord.word = word
        englishWord.translation = trans
   
        self.words.append(englishWord)
        self.tableView.reloadData()
        
        
        // save word to file
        self.saveData()
        
        // -----
        
        // clear the ui
        textboxWord.text = ""
        textboxTranslation.text = ""
        
    }
    
    func saveData() {
        // convert words to json format
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let jsonData = try encoder.encode(self.words)
            
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
           
                // get path to output file
                let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                let finalPath = paths[0]
                
                let filename = finalPath.appendingPathComponent("DictionaryWords.json")
                print("Path of output file: \(filename)")
                
                // save words to output file
                try jsonString.write(to: filename, atomically: true, encoding: String.Encoding.utf8)

            }
            
        }
        catch{
            print("Error converting or saving to JSON")
            print(error.localizedDescription)
        }

    }
}

