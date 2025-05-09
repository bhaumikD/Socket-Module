//
//	ChatDataResponse.swift
//
//	Create by Devubha Manek on 27/7/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ChatDataResponse : Decodable{

	var arrChatData : [ChatData]
	var msg : String
	var status : Bool
    
    private enum CodingKeys: String, CodingKey {
        case arrChatData = "data"
        case msg, status
    }
}

struct ChatData : Decodable{
    
    var conversationId : Int
    var email : String
    var id : Int
    var userId : Int
    var name : String
    var unreadCount : Int
    var lastMessage : LastMessage
    
    private enum CodingKeys : String, CodingKey {
        case conversationId = "conversation_id"
        case unreadCount = "unread_msg_count"
        case lastMessage = "last_msg"
        case userId = "user_id"
        case email,id,name
    }
}

struct LastMessage : Decodable{
    
    var body : String
    var createdAt : String
    var name : String
    var senderId : Int
    var type : String
    
    private enum CodingKeys : String, CodingKey {
        case createdAt = "created_at"
        case senderId = "sender_id"
        case body,type,name
    }
    
}
