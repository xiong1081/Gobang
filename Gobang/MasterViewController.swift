//
//  MasterViewController.swift
//  Gobang
//
//  Created by 李招雄 on 2020/8/1.
//  Copyright © 2020 李招雄. All rights reserved.
//

import UIKit
import Combine
import Network

class MasterViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet var hostView: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var hostButton: UIButton!

    @IBOutlet var cancelView: UIView!
    @IBOutlet var hostingLabel: UILabel!
    
    var cancellable: Cancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: UITextField.textDidChangeNotification, object: nil, queue: nil) { (notif) in
            self.hostButton.isEnabled = self.textField.text?.count != 0
        }
        initSubviews()
        cancellable = NetworkManager.shared.listenerStateSubject.sink { (state) in
            if state == .ready {
                self.hostView.removeFromSuperview()
                self.hostingLabel.text = "\(NetworkManager.shared.listener.port!.rawValue)"
                self.stackView.insertArrangedSubview(self.cancelView, at: 1)
             } else {
                self.cancelView.removeFromSuperview()
                self.stackView.insertArrangedSubview(self.hostView, at: 1)
             }
        }
    }
    
    func initSubviews() {
        //        Bundle.main.loadNibNamed("TableViewCells", owner: self, options: nil)
        UINib(nibName: "MasterViewControllerHostViews", bundle: nil).instantiate(withOwner: self, options: nil)
//        self.stackView.insertArrangedSubview(hostView, at: 1)
        let hostConstraint = NSLayoutConstraint(item: hostView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 44)
        hostView.addConstraint(hostConstraint)
        let cancelConstraint = NSLayoutConstraint(item: cancelView!, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 44)
        cancelView.addConstraint(cancelConstraint)
    }

    @IBAction func tapHostButton(_ sender: UIButton) {
        view.endEditing(true)
        NetworkManager.shared.listener.start(queue: .main)
    }

    @IBAction func tapCancelButton(_ sender: UIButton) {
    }
    
    // MARK: - UITableViewDataSource
    
    
    
    // MARK: UITableViewDelegate
    
    
}

extension MasterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        default:
            return UITableViewCell()
        }
    }
    
}

extension MasterViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}
