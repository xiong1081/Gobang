//
//  PeerConnection.swift
//  Gobang
//
//  Created by 李招雄 on 2020/7/5.
//  Copyright © 2020 李招雄. All rights reserved.
//

import Network

class NetworkConnection {
    
    static let shared = NetworkConnection()
    
    var connection: NWConnection?

    func connect(endpoint: NWEndpoint, success: @escaping () -> Void) {
        let connection = NWConnection(to: endpoint, using: NWParameters.tcp)
        connection.stateUpdateHandler = { newState in
            switch newState {
            case .ready:
                success()
                print("\(connection) established")
            case .failed(let error):
                print("\(connection) failed with \(error)")
            default:
                break
            }
        }
        connection.start(queue: .main)
        self.connection = connection
    }
}
