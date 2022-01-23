//
//  NoteUITableViewCell.swift
//  TechInterview
//
//  Created by Anton Smirnov on 21.01.2022.
//

import UIKit

class NoteUITableViewCell: UITableViewCell {
    
    private(set) var noteTitle : String = ""
    
    @IBOutlet weak var noteTitleLabel: UILabel!
}
