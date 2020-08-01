//
//  GameProtocol.swift
//  Gobang
//
//  Created by 李招雄 on 2020/7/5.
//  Copyright © 2020 李招雄. All rights reserved.
//

import Network

// Create a class that implements a framing protocol.
class GameProtocol: NWProtocolFramerImplementation {
    // Create a global definition of your game protocol to add to connections.
    static let definition = NWProtocolFramer.Definition(implementation: GameProtocol.self)
    // Set a name for your protocol for use in debugging.
    static var label: String { return "TicTacToe" }

    // Set the default behavior for most framing protocol functions.
    required init(framer: NWProtocolFramer.Instance) { }
    func start(framer: NWProtocolFramer.Instance) -> NWProtocolFramer.StartResult { return .ready }
    func wakeup(framer: NWProtocolFramer.Instance) { }
    func stop(framer: NWProtocolFramer.Instance) -> Bool { return true }
    func cleanup(framer: NWProtocolFramer.Instance) { }

    // Whenever the application sends a message, add your protocol header and forward the bytes.
    func handleOutput(framer: NWProtocolFramer.Instance, message: NWProtocolFramer.Message, messageLength: Int, isComplete: Bool) {
//        // Extract the type of message.
//        let type = message.gameMessageType
//
//        // Create a header using the type and length.
//        let header = GameProtocolHeader(type: type.rawValue, length: UInt32(messageLength))
//
//        // Write the header.
//        framer.writeOutput(data: header.encodedData)
//
//        // Ask the connection to insert the content of the application message after your header.
//        do {
//            try framer.writeOutputNoCopy(length: messageLength)
//        } catch let error {
//            print("Hit error writing \(error)")
//        }
    }

    // Whenever new bytes are available to read, try to parse out your message format.
    func handleInput(framer: NWProtocolFramer.Instance) -> Int {
        return 0
//        while true {
//            // Try to read out a single header.
//            var tempHeader: GameProtocolHeader? = nil
//            let headerSize = GameProtocolHeader.encodedSize
//            let parsed = framer.parseInput(minimumIncompleteLength: headerSize,
//                                           maximumLength: headerSize) { (buffer, isComplete) -> Int in
//                guard let buffer = buffer else {
//                    return 0
//                }
//                if buffer.count < headerSize {
//                    return 0
//                }
//                tempHeader = GameProtocolHeader(buffer)
//                return headerSize
//            }
//
//            // If you can't parse out a complete header, stop parsing and ask for headerSize more bytes.
//            guard parsed, let header = tempHeader else {
//                return headerSize
//            }
//
//            // Create an object to deliver the message.
//            var messageType = GameMessageType.invalid
//            if let parsedMessageType = GameMessageType(rawValue: header.type) {
//                messageType = parsedMessageType
//            }
//            let message = NWProtocolFramer.Message(gameMessageType: messageType)
//
//            // Deliver the body of the message, along with the message object.
//            if !framer.deliverInputNoCopy(length: Int(header.length), message: message, isComplete: true) {
//                return 0
//            }
//        }
    }
}
