//
//  SocketIOManager.swift
//  Bozzi
//
//  Created by Dilip manek on 06/10/17.
//  Copyright © 2017 Devubha Manek. All rights reserved.
//

import UIKit
import SocketIO

class SocketIOManager: NSObject {

    static let instance = SocketIOManager()
    var socket = SocketIOClient(socketURL: URL(string: "http://199.250.201.83:8888")!, config: [.log(false), .forceNew(true), .reconnects(true), .forcePolling(true)])
    
    override init() {
        super.init()
        
        socket.on(clientEvent: .connect) {data, ack in
            print("socket connected")
        }
        socket.on(clientEvent: .reconnect) { data, ack in
            print("Socket Reconnceted")
        }
        socket.on(clientEvent: .error) { data, ack in
            print("error:\(data)")
        }
    }
    
    func establishConnection() {
        socket.connect()
        
    }
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendSocketMessage(socketid:String, msgData:[String:Any]){
        SocketIOManager.instance.socket.emit(socketid, with: [msgData])
    }
    func startTypingSocketMessage(socketid:String, msgData:[String:Any]){
        SocketIOManager.instance.socket.emit(socketid, with: [msgData])
    }
    func stopTypingSocketMessage(socketid:String, msgData:[String:Any]){
        SocketIOManager.instance.socket.emit(socketid, with: [msgData])
    }
    
    func readSocketMessage(socketid:String, userId:String, conversationId:Int){
        let dic:[String : Any] = [
            "user_id":userId,
            "conversation_id" : conversationId,
            ]
        SocketIOManager.instance.socket.emit(socketid, with: [dic])
    }
}
