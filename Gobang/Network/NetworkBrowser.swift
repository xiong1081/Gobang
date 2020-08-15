//
//  NetworkBroswer.swift
//  Gobang
//
//  Created by 李招雄 on 2020/8/14.
//  Copyright © 2020 李招雄. All rights reserved.
//

import Network
import Combine

class NetworkBrowser {
    
    static let shared = NetworkBrowser()
    
    let resultSubject = CurrentValueSubject<Set<NWBrowser.Result>, Never>(Set())
    
    private(set) var browser: NWBrowser = {
        let parameters = NWParameters()
//        parameters.includePeerToPeer = true
        let browser = NWBrowser(for: .bonjour(type: "_airplay._tcp", domain: nil), using: parameters)
        return browser
    }()
    
    init() {
        browser.stateUpdateHandler = { newState in
            switch newState {
            case .failed(let error):
                print("Browser failed with \(error)")
                self.browser.cancel()
            default:
                break
            }
        }
        browser.browseResultsChangedHandler = { results, changes in
            self.resultSubject.send(results)
        }
    }
    
}
