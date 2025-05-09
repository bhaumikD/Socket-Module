//
//	ConversationDataResponse.swift
//
//	Create by Devubha Manek on 1/8/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation

struct ConversationDataResponse : Decodable{
    var conversation : [Conversation]!
    var msg : String!
    var response : String!
    private enum CodingKeys : String, CodingKey {
        case conversation = "data"
        case msg,response
    }

}
struct SingleConversationDataResponse : Decodable{
    var conversation : Conversation!
    var msg : String!
    var response : String!
    private enum CodingKeys : String, CodingKey {
        case conversation = "data"
        case msg,response
    }
    
}
struct ConversationData : Decodable{
    var body : String
    var conversationId : Int
    var createdAt : String
    var date : String?
    var id : Int
    var type : String
    var updatedAt : String
    var userId : Int
    
    private enum CodingKeys : String, CodingKey {
        case conversationId = "conversation_id"
        case userId = "user_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case id,body,type
    }
    
    init(dict:[String:Any]) {
        

        self.body = dict["body"] as! String
        self.conversationId = Int("\(dict["conversation_id"]!)")!
        self.createdAt = getFromUTCTolocalDateHH(strDate:dict["created_at"] as! String)
        self.date = getFromUTCToShortlocalDate(strDate:dict["created_at"] as! String)
        self.id = Int("\(dict["id"]!)")!
        self.type = dict["type"] as! String
        self.updatedAt = dict["updated_at"] as! String
        self.userId = Int("\(dict["user_id"]!)")!
    }
    
}

