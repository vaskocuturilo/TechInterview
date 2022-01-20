//
//  CommercialNoteCreateChangeViewController.swift
//  TechInterview
//
//  Created by Anton Smirnov on 18.01.2022.
//

import UIKit

class NoteCreateChangeViewController: UIViewController, UITextViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var noteDoneButton: UIButton!
    
    private let noteCreationTimeStamp : Int64 = Date().toSeconds()
    
    private(set) var changingReallySimpleNote : NotesModelData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteTextView.delegate = self
        
        if let changingReallySimpleNote = self.changingReallySimpleNote {
            noteDateLabel.text = NotesDateHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
            noteTextView.text = changingReallySimpleNote.noteText
            noteTitleTextField.text = changingReallySimpleNote.noteTitle
            noteDoneButton.isEnabled = true
        } else {
            noteDateLabel.text = NotesDateHelper.convertDate(date: Date.init(seconds: noteCreationTimeStamp))
        }
        
        noteTextView.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).cgColor
        noteTextView.layer.borderWidth = 1.0
        noteTextView.layer.cornerRadius = 5
        
        let backBTN = UIBarButtonItem(image: UIImage(named: "Image-2"),
                                      style: .plain,
                                      target: navigationController,
                                      action: #selector(UINavigationController.popViewController(animated:)))
        navigationItem.leftBarButtonItem = backBTN
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
    }
    
    @IBAction func tapAddButton(_ sender: Any) {
        addItem()
        
    }
    
    func setChangingReallySimpleNote(changingReallySimpleNote : NotesModelData) {
        self.changingReallySimpleNote = changingReallySimpleNote
    }
    
    
    private func addItem() -> Void {
        let note = NotesModelData(
            noteTitle:     noteTitleTextField.text!,
            noteText:      noteTextView.text,
            noteTimeStamp: noteCreationTimeStamp)
        
        NotesStorage.storage.addNote(noteToBeAdded: note)
        
        performSegue(
            withIdentifier: "backToMasterView",
            sender: self)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if ( noteTitleTextField.text?.isEmpty ?? true ) || ( textView.text?.isEmpty ?? true ) {
            noteDoneButton.isEnabled = false
        } else {
            noteDoneButton.isEnabled = true
        }
    }
}
