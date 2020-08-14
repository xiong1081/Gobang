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
    var results = [NWBrowser.Result]()
    
    @IBOutlet var hostView: UIView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var hostButton: UIButton!

    @IBOutlet var cancelView: UIView!
    @IBOutlet var hostingLabel: UILabel!
    
    var cancellable0: Cancellable?
    var cancellable1: Cancellable?
    var cancellable2: Cancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        initSubviews()
        NetworkBroswer.shared.browser.start(queue: .main)
        cancellable0 = NetworkListner.shared.stateSubject.sink { [weak self] state in
            self?.refresh(state)
        }
        cancellable1 = NetworkBroswer.shared.resultSubject.sink { [weak self] results in
            self?.results = Array(results)
            self?.tableView.reloadData()
        }
        cancellable2 = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification).sink { (notif) in
            self.hostButton.isEnabled = self.textField.text?.count != 0
        }
    }
    
    func refresh(_ state: NWListener.State) {
        if state == .ready {
           self.hostView.removeFromSuperview()
            if let service = NetworkListner.shared.listener.service,
                let name = service.name {
                self.hostingLabel.text = "\(name)"
            } else {
                self.hostingLabel.text = "\(NetworkListner.shared.listener.port!.rawValue)"
            }
           self.stackView.insertArrangedSubview(self.cancelView, at: 1)
        } else {
           self.cancelView.removeFromSuperview()
           self.stackView.insertArrangedSubview(self.hostView, at: 1)
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    @IBAction func tapHostButton(_ sender: UIButton) {
        view.endEditing(true)
        NetworkListner.shared.listener.start(queue: .main)
    }

    @IBAction func tapCancelButton(_ sender: UIButton) {
    }
    
}

extension MasterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        if case let NWEndpoint.service(name, _, _, _) = results[indexPath.row].endpoint {
            cell.textLabel?.text = name
        }
        return cell
    }
    
}

extension MasterViewController: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
}
