//
//  NoteUITableViewCell.swift
//  TechInterview
//
//  Created by Anton Smirnov on 21.01.2022.
//

import UIKit

class NoteUITableViewCell: UITableViewCell {

    private(set) var noteTitle : String = ""
    private(set) var noteText  : String = ""
    private(set) var noteDate  : String = ""
    
   // @IBOutlet weak var noteTitleLabel: UILabel!
    //@IBOutlet weak var noteDateLabel: UILabel!
    //@IBOutlet weak var noteTextLabel: UILabel!

    @IBOutlet weak var noteTitleLabel: UILabel!
    
    @IBOutlet weak var noteTextLabel: UILabel!
    @IBOutlet weak var noteDateLabel: UILabel!
}
