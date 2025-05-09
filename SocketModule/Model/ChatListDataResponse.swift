//
//	ChatListDataResponse.swift
//
//	Create by Devubha Manek on 7/8/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ChatListDataResponse : Decodable {

	var chatListData : [ChatListData]!
	var msg : String!
	var response : String!
    private enum CodingKeys : String, CodingKey {
        case chatListData = "data"
        case msg,response
    }
}
struct ChatListData : Decodable {
    var createdAt : String!
    var id : Int!
    var image : String!
    var isPrivate : String!
    var lastMessage : Conversation!
    var name : String!
    var pivot : Pivot!
    var unreadMessagesCount : Int!
    var updatedAt : String!
    var withUser : WithUser!
    private enum CodingKeys : String, CodingKey {
        case createdAt = "created_at"
        case isPrivate = "is_private"
        case lastMessage = "last_message"
        case unreadMessagesCount = "unread_messages_count"
        case updatedAt = "updated_at"
        case withUser = "with_user"
        case id,image,name,pivot
    }
}
struct Conversation : Decodable {
    var conversationId : Int!
    var createdAt : String!
    var id : Int!
    var isSeen : Int!
    var isSender : Int!
    var message : Message!
    var messageId : Int!
    var updatedAt : String!
    var userId : Int!
    private enum CodingKeys : String, CodingKey {
        case conversationId = "conversation_id"
        case createdAt = "created_at"
        case isSeen = "is_seen"
        case isSender = "is_sender"
        case messageId = "message_id"
        case updatedAt = "updated_at"
        case userId = "user_id"
        case id,message
    }
}
struct Message : Decodable {
    
    var body : String!
    var conversationId : Int!
    var createdAt : String!
    var date : String!
    var extra : String!
    var id : Int!
    var sender : Sender!
    var type : String!
    var updatedAt : String!
    var userId : Int!
    private enum CodingKeys : String, CodingKey {
        case conversationId = "conversation_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userId = "user_id"
        case id,body,extra,sender,type
    }
}
struct Pivot : Decodable {
    
    var conversationId : Int!
    var createdAt : String!
    var updatedAt : String!
    var userId : Int!
    private enum CodingKeys : String, CodingKey {
        case conversationId = "conversation_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case userId = "user_id"
    }
}
struct Sender : Decodable {
    var id : Int!
    var name : String!
    private enum CodingKeys : String, CodingKey {
        case id,name
    }
}
struct WithUser : Decodable {
    var conversationId : Int!
    var createdAt : String!
    var id : Int!
    var isAdmin : Int!
    var mute : String!
    var status : String!
    var updatedAt : String!
    var user : Sender!
    var userId : Int!
    private enum CodingKeys : String, CodingKey {
        case conversationId = "conversation_id"
        case createdAt = "created_at"
        case isAdmin = "is_admin"
        case updatedAt = "updated_at"
        case userId = "user_id"
        case id,mute,status,user
    }
}
