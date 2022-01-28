//
//  ViewController.swift
//  TechInterview
//
//  Created by Anton Smirnov on 18.01.2022.
//

import UIKit

class MasterViewController: UITableViewController {
    
    var previousNumber: UInt32?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            let alert = UIAlertController(
                title: "Could note get app delegate",
                message: "Could note get app delegate, unexpected error occurred. Try again later.",
                preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK",
                                          style: .default))
            self.present(alert, animated: true)
            
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        NotesStorage.storage.setManagedContext(managedObjectContext: managedContext)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Random", style: .plain, target: self, action: #selector(randomNewObject))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(insertNewObject))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
        performSegue(withIdentifier: "showCreateNoteSegue", sender: self)
    }
    
    @objc
    func randomNewObject(_ sender: Any) {
        let object = NotesStorage.storage.readNote(at: Int(randomNumber()))
        let refreshAlert = UIAlertController(title: "Random exercise", message: object?.noteTitle, preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Fail", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Pass", style: .default, handler: { (action: UIAlertAction!) in
            print("Handle PASS")
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    func randomNumber() -> UInt32 {
        var randomNumber = arc4random_uniform(UInt32(NotesStorage.storage.count()))
        while previousNumber == randomNumber {
            randomNumber = arc4random_uniform(UInt32(NotesStorage.storage.count()))
        }
        previousNumber = randomNumber
        return randomNumber
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                //let object = objects[indexPath.row]
                let object = NotesStorage.storage.readNote(at: indexPath.row)
                let controller = segue.destination as! DetailViewController
                controller.detailItem = object
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return NotesStorage.storage.count()
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NoteUITableViewCell
        
        if let object = NotesStorage.storage.readNote(at: indexPath.row) {
            cell.noteTitleLabel!.text = object.noteTitle
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showDetail", sender: self)
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            NotesStorage.storage.removeNote(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
        }
    }
}

