//
//  PeerBrowser.swift
//  Gobang
//
//  Created by 李招雄 on 2020/7/5.
//  Copyright © 2020 李招雄. All rights reserved.
//

import Network

class PeerBrowser {
    private var browser: NWBrowser = {
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
    
    func start() {
        browser.start(queue: .main)
    }
}
