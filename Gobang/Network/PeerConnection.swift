//
//  PeerConnection.swift
//  Gobang
//
//  Created by 李招雄 on 2020/7/5.
//  Copyright © 2020 李招雄. All rights reserved.
//

import Network

class PeerConnection {
    static var shared: PeerConnection?
    var connection: NWConnection?
    let initiatedConnection: Bool
    
    // Create an outbound connection when the user initiates a game.
    init(endpoint: NWEndpoint, interface: NWInterface?, passcode: String) {
        self.initiatedConnection = true
        self.connection = NWConnection(to: endpoint, using: NWParameters(passcode: passcode)) 
        startConnection()
    }

    // Handle an inbound connection when the user receives a game request.
    init(connection: NWConnection) {
        self.connection = connection
        self.initiatedConnection = false
        startConnection()
    }

    // Handle the user exiting the game.
    func cancel() {
        if let connection = self.connection {
            connection.cancel()
            self.connection = nil
        }
    }
    
    func startConnection() {
        guard let connection = connection else {
            return
        }
        connection.stateUpdateHandler = { newState in
            switch newState {
            case .ready:
                print("\(connection) established")
            case .failed(let error):
                print("\(connection) failed with \(error)")
            default:
                break
            }
        }
        connection.start(queue: .main)
    }
}
