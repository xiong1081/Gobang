//
//  MasterViewController.swift
//  Gobang
//
//  Created by 李招雄 on 2020/8/1.
//  Copyright © 2020 李招雄. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var hostButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: nil) { (notif) in
            self.hostButton.isEnabled = self.textField.text?.count != 0
        }
    }

    @IBAction func tapHostButton(_ sender: UIButton) {
        view.endEditing(true)
        
    }
    
}

extension MasterViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}
