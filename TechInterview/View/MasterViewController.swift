//
//  ViewController.swift
//  TechInterview
//
//  Created by Anton Smirnov on 18.01.2022.
//

import UIKit

class MasterViewController: UITableViewController {
    
    private let composeButton: UIButton = {
        
        let button = UIButton()
        
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.setImage(UIImage(systemName: "",
                                withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium)),for: .normal)
        button.layer.cornerRadius = 40
        button.layer.shadowColor = UIColor.label.cgColor
        button.layer.shadowOpacity = 0.4
        button.layer.shadowRadius = 10
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(composeButton)
        composeButton.addTarget(self, action:#selector(insertNewObject(_:)), for:.touchUpInside )
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        composeButton.frame = CGRect(x: view.frame.width - 80 - 40,
                                     y: view.frame.height - 80 - 70 - view.safeAreaInsets.bottom,
                                     width: 80,
                                     height: 80)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // clearsSelectionOnViewWillAppear = (detailViewController != nil)
        super.viewWillAppear(animated)
    }
    
    @objc
    func insertNewObject(_ sender: Any) {
      performSegue(withIdentifier: "showCreateNoteSegue", sender: self)
    }

}

