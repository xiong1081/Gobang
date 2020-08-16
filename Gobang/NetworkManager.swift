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
    
    // MARK: - Listner
    
    let stateSubject = CurrentValueSubject<NWListener.State, Never>(NWListener.State.setup)
    let connectSubject = PassthroughSubject<NWConnection, Never>()

    private(set) var listener: NWListener?
    
    func listen() {
        do {
            let listener = try NWListener(using: NWParameters.tcp)
            listener.service = NWListener.Service(name: UIDevice.current.name, type: "_airplay._tcp")
            listener.stateUpdateHandler = { [unowned self] newState in
                switch newState {
                case .ready:
                    print("Listener ready on \(String(describing: listener.port))")
                case .failed(let error):
                    print("Listener failed with \(error)")
                    listener.cancel()
                default:
                    break
                }
                self.stateSubject.send(newState)
            }
            listener.newConnectionHandler = { newConnection in
                self.connection = newConnection
                self.connectSubject.send(newConnection)
            }
            listener.start(queue: .main)
            self.listener = listener
        } catch {
            print("Failed to create listener")
            abort()
        }
    }
    
    // MARK: - Browser
    
    let resultSubject = CurrentValueSubject<Set<NWBrowser.Result>, Never>(Set())
        
    private(set) var browser: NWBrowser?
    
    func browse() {
        let parameters = NWParameters.tcp
        //        parameters.includePeerToPeer = true
        let browser = NWBrowser(for: .bonjour(type: "_airplay._tcp", domain: nil), using: parameters)
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
            self.resultSubject.send(results)
        }
        browser.start(queue: .main)
        self.browser = browser
    }
    
    // MARK: - Connection
    
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
