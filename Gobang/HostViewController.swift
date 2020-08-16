//
//  HostViewController.swift
//  Gobang
//
//  Created by 李招雄 on 2020/8/16.
//  Copyright © 2020 李招雄. All rights reserved.
//

import UIKit
import Combine

class HostViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var values = ["", ""]
    let keys = ["service", "state"]
    
    var cancellable0: Cancellable?
    var cancellable3: Cancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        cancellable0 = NetworkManager.shared.stateSubject.sink { [weak self] state in
            let service = NetworkManager.shared.listener?.service?.debugDescription
            self?.values = [service ?? "", String(describing: state)]
            self?.tableView.reloadData()
        }
        NetworkManager.shared.listen()
        cancellable3 = NetworkManager.shared.connectSubject.sink { connection in
            self.navigationController?.pushViewController(GameViewController(), animated: true)
        }
    }
    
    deinit {
        NetworkManager.shared.listener?.cancel()
    }

}

extension HostViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "\(keys[indexPath.row]): \(values[indexPath.row])"
        return cell
    }
    
}
