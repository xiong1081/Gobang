//
//  PeerListener.swift
//  Gobang
//
//  Created by 李招雄 on 2020/7/5.
//  Copyright © 2020 李招雄. All rights reserved.
//

import Network
import UIKit
import Combine

class NetworkListner {
    
    static let shared = NetworkListner()
    
    let stateSubject = CurrentValueSubject<NWListener.State, Never>(NWListener.State.setup)
    
    private(set) var listener: NWListener = {
        do {
            let listener = try NWListener(using: NWParameters.tcp)
            let name = "Hosting: \(UInt8.random(in: 0...99))"
            listener.service = NWListener.Service(name: name, type: "_airplay._tcp")
            return listener
        } catch {
            print("Failed to create listener")
            abort()
        }
    }()
        
    init() {
        listener.stateUpdateHandler = { [unowned self] newState in
            switch newState {
            case .ready:
                print("Listener ready on \(String(describing: self.listener.port))")
            case .failed(let error):
                print("Listener failed with \(error)")
                self.listener.cancel()
            default:
                break
            }
            self.stateSubject.send(newState)
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
    }
    
}
