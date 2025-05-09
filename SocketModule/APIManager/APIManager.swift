//
//  APIManager.swift
//  SocketModule
//
//  Created by Devubha Manek on 26/07/18.
//  Copyright © 2018 Devubha Manek. All rights reserved.
//

import UIKit
import Alamofire
//MARK: - APIManager
class APIManager: NSObject {
    
    //TODO: - Register Api
    func callRegisterApi(perameter:[String:Any], dataResponse:@escaping (DataResponse<Any>)->()){
        let url = WebURL.register
        Alamofire.request(url, method: .post, parameters: perameter).responseJSON { (response) in
            dataResponse(response)
        }
    }
    
    //TODO: - Login Api
    func callLoginApi(perameter:[String:Any], dataResponse:@escaping (DataResponse<Any>)->()){
        let url = WebURL.login
        Alamofire.request(url, method: .post, parameters: perameter).responseJSON { (response) in
            dataResponse(response)
        }
    }
    
    //TODO: - Chat List Api
    func callChatListApi(perameter:[String:Any], dataResponse:@escaping (DataResponse<Any>)->()){
        let url = WebURL.getChatList
        Alamofire.request(url, method: .post, parameters: perameter).responseJSON { (response) in
            dataResponse(response)
        }
    }
    //TODO: - Chat Data Api
    func callChatDataApi(perameter:[String:Any], dataResponse:@escaping (DataResponse<Any>)->()){
        let url = WebURL.getConversationChat
        Alamofire.request(url, method: .post, parameters: perameter).responseJSON { (response) in
            dataResponse(response)
        }
    }
    //TODO: - Send Image Api
    func callSendImageApi(perameter:[String:Any], image:UIImage, encodingResult:@escaping (SessionManager.MultipartFormDataEncodingResult)->()){
        let url = WebURL.sendMsg
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 360000
        manager.session.configuration.timeoutIntervalForResource = 360000
        
        manager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(UIImageJPEGRepresentation(image, 0.8)!, withName: "body", fileName: "image.jpeg", mimeType: "image/jpeg")
            for (key, value) in perameter {
                multipartFormData.append((String(describing: value) as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: url, method: .post) { response in
            encodingResult(response)
        }
    }
    //TODO: - Send Video Api
    func callSendVideoApi(perameter:[String:Any], videoData:Data, thumbImage:UIImage, encodingResult:@escaping (SessionManager.MultipartFormDataEncodingResult)->()){
        let url = WebURL.sendMsg
        let manager = Alamofire.SessionManager.default
        manager.session.configuration.timeoutIntervalForRequest = 360000
        manager.session.configuration.timeoutIntervalForResource = 360000
        
        manager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(videoData, withName: "body", fileName: "video.mp4", mimeType: "video/mp4")
            multipartFormData.append(UIImageJPEGRepresentation(thumbImage, 0.8)!, withName: "video_thumb", fileName: "image.jpeg", mimeType: "image/jpeg")
            for (key, value) in perameter {
                multipartFormData.append((String(describing: value) as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key)
            }
        }, to: url, method: .post) { response in
            encodingResult(response)
        }
    }
    
}
