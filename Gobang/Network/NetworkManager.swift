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

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let listenerStateSubject = CurrentValueSubject<NWListener.State, Never>(NWListener.State.setup)
    
    private(set) var listener: NWListener = {
        do {
            let listener = try NWListener(using: NWParameters.tcp)
            let name = "Hosting: \(UInt8.random(in: 0...99))"
//            listener.service = NWListener.Service(name: name, type: "gobang.tcp")
            return listener
        } catch {
            print("Failed to create listener")
            abort()
        }
    }()
    
    private(set) var browser: NWBrowser = {
        let parameters = NWParameters()
        parameters.includePeerToPeer = true
        let browser = NWBrowser(for: .bonjour(type: "gobang.tcp", domain: nil), using: parameters)
        browser.stateUpdateHandler = { newState in
            switch newState {
            case .failed(let error):
                print("Browser failed with \(error)")
                browser.cancel()
            default:
                break
            }
        }
        browser.browseResultsChangedHandler = { results, changes in
            
        }
        return browser
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
            self.listenerStateSubject.send(newState)
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
