//
//  PeerListener.swift
//  Gobang
//
//  Created by 李招雄 on 2020/7/5.
//  Copyright © 2020 李招雄. All rights reserved.
//

import Network
import UIKit

class PeerListener {
    var listener: NWListener?
    static var shared: PeerListener?
    
    init(name: String, passcode: String) {
        do {
            let listener = try NWListener(using: NWParameters(passcode: passcode))
            self.listener = listener
            listener.service = NWListener.Service(name: name, type: "gobang.tcp")
            listener.stateUpdateHandler = { newState in
                switch newState {
                case .ready:
                    print("Listener ready on \(String(describing: listener.port))")
                case .failed(let error):
                    print("Listener failed with \(error)")
                    listener.cancel()
                default:
                    break
                }
            }
            listener.newConnectionHandler = { newConnection in
                if PeerConnection.shared == nil {
                    // Accept a new connection.
                    PeerConnection.shared = PeerConnection(connection: newConnection)
                } else {
                    // If a game is already in progress, reject it.
                    newConnection.cancel()
                }
            }
            listener.start(queue: .main)
        } catch {
            print("Failed to create listener")
            abort()
        }
    }
}
