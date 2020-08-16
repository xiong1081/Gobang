//
//  JoinViewController.swift
//  Gobang
//
//  Created by 李招雄 on 2020/8/16.
//  Copyright © 2020 李招雄. All rights reserved.
//

import UIKit
import Combine
import Network

class JoinViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var results = [NWBrowser.Result]()

    var cancellable1: Cancellable?

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        cancellable1 = NetworkManager.shared.resultSubject.sink { [weak self] results in
            self?.results = Array(results)
            self?.tableView.reloadData()
        }
        NetworkManager.shared.browse()
        
    }
    
    deinit {
        NetworkManager.shared.browser?.cancel()
    }
    
}

extension JoinViewController: UITableViewDataSource {
    
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

extension JoinViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let endpoint = results[indexPath.row].endpoint
        NetworkManager.shared.connect(endpoint: endpoint) {
            self.navigationController?.pushViewController(GameViewController(), animated: true)
        }
    }
    
}
