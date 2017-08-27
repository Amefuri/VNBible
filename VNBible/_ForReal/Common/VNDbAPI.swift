//
//  MySocket.swift
//  VNBible
//
//  Created by peerapat atawatana on 1/18/2560 BE.
//  Copyright © 2560 DaydreamClover. All rights reserved.
//

import Foundation
import CocoaAsyncSocket
import SwiftyJSON

public enum VNDbAPICommand: CustomStringConvertible {
    case login
    case get

    public var description: String {
        switch self {
        case .login:
            return "login"
        case .get:
            return "get"
        }
    }
}

public enum VNDbAPICommandType: CustomStringConvertible {
    case vn
    case release
    case producer
    case character
    case user
    case voteList
    case vnList
    case wishList
    
    public var description: String {
        switch self {
        case .vn:
            return "vn"
        case .release:
            return "release"
        case .producer:
            return "producer"
        case .character:
            return "character"
        case .user:
            return "user"
        case .voteList:
            return "votelist"
        case .vnList:
            return "vnlist"
        case .wishList:
            return "wishlist"
        }
    }
}

public enum VNDbAPICommandFlag: CustomStringConvertible {
    case basic
    case details
    case anime
    case relations
    
    public var description: String {
        switch self {
        case .basic:
            return "basic"
        case .details:
            return "details"
        case .anime:
            return "anime"
        case .relations:
            return "relations"
        }
    }
}

public enum VNDbAPIResult<U> {
    case success(result: U)
    case fail(error: VNDbAPIError)
}

public enum VNDbAPIError: Error {
    
}

public protocol VNDbAPIProtocol {
    var connected:Bool { get }
    func connect(_ completion: VNDbAPIConnectCompletionHandler?)
    func login(username:String, password:String, completion: VNDbAPICompletionHandler?)
    func send(command:VNDbAPICommand, type:VNDbAPICommandType?, flags:[VNDbAPICommandFlag]?, filters:CustomStringConvertible?, data:[String:Any]?, completion: VNDbAPICompletionHandler?)
}

public protocol VNDbAPIQueryProtocol {
    
}

public typealias VNDbAPICompletionHandler           = (_ result: VNDbAPIResult<String>) -> Void
public typealias VNDbAPIConnectCompletionHandler    = (_ result: VNDbAPIResult<Bool>) -> Void

public class VNDbAPI: NSObject, GCDAsyncSocketDelegate, VNDbAPIProtocol {
        
    fileprivate let host:String                 = "api.vndb.org"
    fileprivate let port:UInt16                 = 19534
    fileprivate var endOfTransmissionFlag:UInt8 = 0x04
    
    fileprivate var socket:GCDAsyncSocket!
    fileprivate var reqID:Int = 0
    fileprivate var connectCompletion:VNDbAPIConnectCompletionHandler?
    fileprivate var completionsDict:Dictionary<Int, VNDbAPICompletionHandler> = [:]
    
    override init() {
        super.init()
        socket = GCDAsyncSocket(delegate: self, delegateQueue: DispatchQueue.main)
    }

    // MARK: Private function
    
    private func addCompletion(of reqID:Int, completion: VNDbAPICompletionHandler?) {
        guard let completion = completion else { return }
        completionsDict[reqID] = completion
    }
    
    private func removeCompletion(of reqID:Int) {
        completionsDict[reqID] = nil
    }
    
    private func getCompletion(of reqID:Int)-> VNDbAPICompletionHandler? {
        return completionsDict[reqID]
    }
    
    // MARK: Socket delegate
    
    public func socket(_ socket : GCDAsyncSocket, didConnectToHost host:String, port p:UInt16) {
        //print("connect success")
        connectCompletion?(VNDbAPIResult.success(result: true))
    }
    
    public func socket(_ sock: GCDAsyncSocket, didWriteDataWithTag tag: Int) {
        //print("write data reqID = " + tag.description)
    }
    
    public func socket(_ sock: GCDAsyncSocket, didRead data: Data, withTag tag: Int) {
        //print("read data reqID = " + tag.description)
        if let dataStr = String(data: data, encoding: .utf8) {
            var resultStr = ""
            let dataArr = dataStr.characters.split(separator: Character(" "), maxSplits: 1, omittingEmptySubsequences: false)
            
            if dataArr.count > 1    { resultStr = String(dataArr[1]) }
            else                    { resultStr = dataStr }
            
            if let completion = getCompletion(of: tag) {
                completion(VNDbAPIResult.success(result: resultStr))
            }
        }
    }
    
    // MARK: Protocol implement
    
    public var connected: Bool {
        return socket.isConnected
    }
    
    public func connect(_ completion: VNDbAPIConnectCompletionHandler?) {
        guard !connected else { print("session already connected"); return }
        do {
            print("Connecting to socket server...")
            connectCompletion = completion
            try socket.connect(toHost: host, onPort: port)
        } catch let error {
            print(error)
        }
    }
    
    public func login(username: String, password: String, completion: VNDbAPICompletionHandler?) {
        send(command: .login,
             type: nil,
             flags: nil,
             filters:nil,
             data: ["username":   username,
                    "password":   password,
                    "protocol":   "1",
                    "client":     "VNBible",
                    "clientver":  "0.1"],
             completion: completion)
    }
    
    public func send(command:VNDbAPICommand, type:VNDbAPICommandType?, flags:[VNDbAPICommandFlag]?, filters:CustomStringConvertible?, data:[String : Any]?, completion: VNDbAPICompletionHandler?) {
        guard connected                                     else { print("Session not connected");      return }
       
        // Command
        var packet = "\(command)"
        // Type
        if let type = type {
            packet += " \(type)"
        }
        // Flags
        if let flags = flags {
            packet += " " + flags.reduce("", {  $0 == "" ? "\($1)" : "\($0),\($1)" })
        }
        // Filters
        if let filters = filters {
            packet += " \(filters)"
        }
        // Data
        if let data = data, let dataJSON = JSON(data).rawString() {
            packet += " " + dataJSON
        }
        
        print("[sendCommand]: " + packet)
        //return // Remove this
        
        guard var packetData = packet.data(using: .utf8) else { print("Cannot encode data"); return }
        
        // Register completion
        
        addCompletion(of: reqID, completion: completion)
        
        // Send
        packetData.append(&endOfTransmissionFlag, count: 1)
        socket.write(packetData, withTimeout: -1, tag: reqID)
        
        // Receive
        var endReadData = Data()
        endReadData.append(&endOfTransmissionFlag, count: 1)
        socket.readData(to: endReadData, withTimeout: -1, tag: reqID)
        reqID += 1
    }
}
