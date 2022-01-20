//
//  CommercialNoteCreateChangeViewController.swift
//  TechInterview
//
//  Created by Anton Smirnov on 18.01.2022.
//

import UIKit

class NoteCreateChangeViewController: UIViewController {
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteTextView: UITextView!
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var noteDoneButton: UIButton!
    
    private(set) var changingReallySimpleNote : NotesModelData?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func setChangingReallySimpleNote(changingReallySimpleNote : NotesModelData) {
        self.changingReallySimpleNote = changingReallySimpleNote
    }
}
