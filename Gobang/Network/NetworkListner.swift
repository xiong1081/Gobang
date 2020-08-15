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
    let connectSubject = PassthroughSubject<NWConnection, Never>()

    private(set) var listener: NWListener = {
        do {
            let listener = try NWListener(using: NWParameters.tcp)
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
            newConnection.start(queue: .main)
            NetworkConnection.shared.connection = newConnection
            self.connectSubject.send(newConnection)
        }
    }
    
    func start(name: String) {
        listener.service = NWListener.Service(name: name, type: "_airplay._tcp")
        listener.start(queue: .main)
    }
    
}
