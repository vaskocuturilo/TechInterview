//
//  DetailViewController.swift
//  TechInterview
//
//  Created by Anton Smirnov on 19.01.2022.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var noteTitleLabel: UILabel!
    
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let topicLabel = noteTitleLabel,
               let dateLabel = noteDateLabel,
               let textView = noteTextView {
                topicLabel.text = detail.noteTitle
                dateLabel.text = NotesDateHelper.convertDate(date: Date.init(seconds: detail.noteTimeStamp))
                textView.text = detail.noteText
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    var detailItem: NotesModelData? {
        didSet {
            // Update the view.
            configureView()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChangeNoteSegue" {
            let changeNoteViewController = segue.destination as! NoteCreateChangeViewController
            if let detail = detailItem {
                changeNoteViewController.setChangingReallySimpleNote(
                    changingReallySimpleNote: detail)
            }
        }
    }
}
