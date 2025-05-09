//
//  SingleChatViewController.swift
//  SocketModule
//
//  Created by Devubha Manek on 11/07/18.
//  Copyright © 2018 Devubha Manek. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import ContactsUI
import MobileCoreServices
import Photos
import GooglePlacePicker
import MapKit

//MARK: - ChatHeaderCell
class ChatHeaderCell:UITableViewCell{
    @IBOutlet var lblTitle: UILabel!
}
//MARK: - SendTextCell
class SendTextCell:UITableViewCell{
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var lblNameBadge:UILabel!
    @IBOutlet var viewBubble: UIView!
    @IBOutlet var lblText: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var viewSelected: UIView!
    
    func setData(dic:Conversation) {
        viewSelected.isHidden = true
        lblText.text = ""
        lblText.text = dic.message.body
        lblNameBadge.text = String(describing:dic.message.sender.name.first!).uppercased()
        lblTime.text = getShortTimeHH(strDate:dic.message.createdAt)
        viewBubble.layer.cornerRadius = 18.0
        selectionStyle = .none
    }
    
}
//MARK: - ReceiveTextCell
class ReceiveTextCell:UITableViewCell{
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var lblNameBadge:UILabel!
    @IBOutlet var viewBubble: UIView!
    @IBOutlet var lblText: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var viewSelected: UIView!
    
    func setData(dic:Conversation) {
        viewSelected.isHidden = true
        lblText.text = ""
        lblText.text = dic.message.body
        lblNameBadge.text = String(describing:dic.message.sender.name.first!).uppercased()
        lblTime.text = getShortTimeHH(strDate:dic.createdAt)
        viewBubble.layer.cornerRadius = 18.0
        selectionStyle = .none
    }
}
//MARK: - SendContactCell
class SendContactCell:UITableViewCell{
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var lblNameBadge:UILabel!
    @IBOutlet var viewBubble: UIView!
    @IBOutlet var lblText: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var viewSelected: UIView!
    
    func setData(dic:Conversation) {
        viewSelected.isHidden = true
        let contact:Contact = Contact(fromString: dic.message.body)
        lblText.text = ""
        lblText.text = contact.givenName + " " + contact.familyName
        lblNameBadge.text = String(describing:dic.message.sender.name.first!).uppercased()
        lblTime.text = getShortTimeHH(strDate:dic.createdAt)
        viewBubble.layer.cornerRadius = 18.0
        selectionStyle = .none
    }
    
}
//MARK: - ReceiveContactCell
class ReceiveContactCell:UITableViewCell{
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var lblNameBadge:UILabel!
    @IBOutlet var viewBubble: UIView!
    @IBOutlet var lblText: UILabel!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var viewSelected: UIView!
    
    func setData(dic:Conversation) {
        viewSelected.isHidden = true
        let contact:Contact = Contact(fromString: dic.message.body)
        lblText.text = ""
        lblText.text = contact.givenName + " " + contact.familyName
        lblNameBadge.text = String(describing:dic.message.sender.name.first!).uppercased()
        lblTime.text = getShortTimeHH(strDate:dic.createdAt)
        viewBubble.layer.cornerRadius = 18.0
        selectionStyle = .none
    }
}
//MARK: - SendMediaCell
class SendMediaCell:UITableViewCell{
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var lblNameBadge:UILabel!
    @IBOutlet var viewBubble: UIControl!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var viewSelected: UIView!
    @IBOutlet var viewVideo: UIView!
    
    func setData(dic:Conversation) {
        self.viewBubble.accessibilityElements = [dic]
        viewSelected.isHidden = true
        viewVideo.isHidden = true
        var mediaUrl = WebURL.imageBaseURL + dic.message.body!
        if dic.message.type == "location" {
            let staticMapUrl:String = "http://maps.google.com/maps/api/staticmap?markers=color:red|\(dic.message.body!)&zoom=16&size=300x300&sensor=true"
            mediaUrl = staticMapUrl
        }else if dic.message.type == "video" {
            viewVideo.isHidden = false
            let extraDic = convertToDictionary(text: dic.message.extra!)
            mediaUrl = WebURL.imageBaseURL + getStringFromDictionary(dictionary: extraDic!, key: "thumb")
        }
        imgView.setShowActivityIndicator(true)
        imgView.setIndicatorStyle(.gray)
        imgView.sd_setImage(with: URL(string: mediaUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!))
        lblTime.text = getShortTimeHH(strDate:dic.createdAt)
        lblNameBadge.text = String(describing:dic.message.sender.name.first!).uppercased()
        viewBubble.layer.cornerRadius = 18.0
        selectionStyle = .none
    }
}
//MARK: - ReceiveMediaCell
class ReceiveMediaCell:UITableViewCell{
    @IBOutlet var imgProfile: UIImageView!
    @IBOutlet var lblNameBadge:UILabel!
    @IBOutlet var viewBubble: UIControl!
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var lblTime: UILabel!
    @IBOutlet var viewSelected: UIView!
    @IBOutlet var viewVideo: UIView!
    
    func setData(dic:Conversation) {
        self.viewBubble.accessibilityElements = [dic]
        viewSelected.isHidden = true
        viewVideo.isHidden = true
        var mediaUrl = WebURL.imageBaseURL + dic.message.body!
        if dic.message.type == "location" {
            let staticMapUrl:String = "http://maps.google.com/maps/api/staticmap?markers=color:red|\(dic.message.body!)&zoom=16&size=300x300&sensor=true"
            mediaUrl = staticMapUrl
        }else if dic.message.type == "video" {
            viewVideo.isHidden = false
            let extraDic = convertToDictionary(text: dic.message.extra!)
            mediaUrl = WebURL.imageBaseURL + getStringFromDictionary(dictionary: extraDic!, key: "thumb")
        }
        imgView.setShowActivityIndicator(true)
        imgView.setIndicatorStyle(.gray)
        imgView.sd_setImage(with: URL(string: mediaUrl.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!))
        lblTime.text = getShortTimeHH(strDate:dic.createdAt)
        lblNameBadge.text = String(describing:dic.message.sender.name.first!).uppercased()
        viewBubble.layer.cornerRadius = 18.0
        selectionStyle = .none
    }
}
//MARK: - SingleChatViewController Protocol
protocol SingleChatViewControllerDelegate{
    func singleChatViewControllerLastMessage(chatListData:ChatListData)
}
//MARK: - SingleChatViewController
class SingleChatViewController: UIViewController {
    //MARK: - Delegate Variable
    var delegate : SingleChatViewControllerDelegate?
    
    //MARK: - Variables
    @IBOutlet var tblChat:UITableView!
    
    //Cancel View
    @IBOutlet var btnCancelDelete: UIControl!
    @IBOutlet var btnCancelDeleteHeight: NSLayoutConstraint!
    
    //Typing indicator
    @IBOutlet var imgTypingProfile: UIImageView!
    @IBOutlet var viewTypingIndicator: UIView!
    @IBOutlet var viewMessageProgress: MessageProgressView!
    @IBOutlet var viewTypingIndicatorHeightConstraint: NSLayoutConstraint!
    
    //Bottom bar
    @IBOutlet var viewBottomBottomConstraint: NSLayoutConstraint!
    @IBOutlet var txtViewComment: UITextView!
    @IBOutlet var txtViewCommentHeightConstraint: NSLayoutConstraint!
    private var localTyping = false
    var isTyping: Bool {
        get {
            return localTyping
        }
        set {
            if localTyping != newValue {
                localTyping = newValue
                if localTyping == true{
                    self.startTyping()
                }else{
                    self.stopTyping()
                }
            }
            
        }
    }
    
    var chatListData:ChatListData!
    var arrConversation:[Conversation] = []
    var arrMessage:[Any] = []
    var arrMWAttachment:[MWPhoto] = []
    var isFromMW:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.isTyping = false
        if arrConversation.count > 0 {
            let sortedKeys = ((self.arrMessage.last as AnyObject).allKeys as! [String])
            let dict:[String:Any] = self.arrMessage.last as! [String:Any]
            let secAry:[Conversation] = dict[sortedKeys[0]] as! [Conversation]
            let dic:Conversation = secAry.last!
            chatListData.lastMessage = dic
            self.delegate?.singleChatViewControllerLastMessage(chatListData: chatListData)
        }
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isFromMW == false {
            //Set Socket off
            self.stopReceiveSocketMessage()
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK:- Initialisation
    func initData(){
        IQKeyboardManager.shared.enable = false
        IQKeyboardManager.shared.enableAutoToolbar = false
        self.title = self.chatListData.withUser.user.name.capitalized
        hideTypingIndicator()
        btnCancelDeleteHeight.constant = 0.0
        self.tblChat.separatorColor = UIColor.clear
        appDelegate.showLoadingIndicator(view: self.view)
        self.callGetChatDataAPI(limit: 0)
        self.setUpObserver()
        if txtViewComment.text.length <= 0 || txtViewComment.text == "Type a message..." {
            txtViewComment.text = "Type a message..."
            txtViewComment.textColor = UIColor.init(red: 141/255.0, green: 140/255.0, blue: 141/255.0, alpha: 1.0)
        }else{
            txtViewComment.textColor = UIColor.black
        }
        //Set Socket on
        self.startReceiveSocketMessage()
        self.getStartTyping()
        self.getStopTyping()
        
        //Set Notification
        NotificationCenter.default.addObserver(self, selector:#selector(appInForegroud), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(appWillResign), name: NSNotification.Name.UIApplicationWillResignActive, object: nil)
    }

}
//MARK: - App State Notification Event
extension SingleChatViewController{
    @objc func appWillResign(){
        self.isTyping = false
    }
    @objc func appInForegroud(){
        print("appInForegroud")
        
        let strReceiveMsg = "send_response_\(chatListData.id!)"
        SocketIOManager.instance.socket.off(strReceiveMsg)
        let strStartTyping = "start_receiving_\(chatListData.id!)"
        SocketIOManager.instance.socket.off(strStartTyping)
        let strStopTyping = "stop_receiving_\(chatListData.id!)"
        SocketIOManager.instance.socket.off(strStopTyping)
        
        self.isTyping = self.txtViewComment.text != ""
        viewDidLoad()
    }
}
//MARK: - UITableView DataSource & Delegate
extension SingleChatViewController:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrMessage.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sortedKeys = ((self.arrMessage[section] as AnyObject).allKeys as! [String])
        let dic:[String:Any] = self.arrMessage[section] as! [String:Any]
        let secAry:[Conversation] = dic[sortedKeys[0]] as! [Conversation]
        return secAry.count
    }
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sortedKeys = ((self.arrMessage[section] as AnyObject).allKeys as! [String])
        let strDt = sortedKeys[0] as String
        let headerView:ChatHeaderCell = tableView.dequeueReusableCell(withIdentifier: "ChatHeaderCell") as! ChatHeaderCell
        let n:Int = getDaysDifference(date:strDt)
        if n == 0 {
            headerView.lblTitle.text = NSLocalizedString("Today", comment: "")
        }else if n == 1 {
            headerView.lblTitle.text = NSLocalizedString("Yesterday", comment: "")
        }else{
            
            headerView.lblTitle.text = strDt
            
        }
        
        return headerView.contentView
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if tableView.isDragging {
            cell.transform = CGAffineTransform.init(scaleX: 0.7, y: 0.7)
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform.identity
            })
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sortedKeys = ((self.arrMessage[indexPath.section] as AnyObject).allKeys as! [String])
        let dict:[String:Any] = self.arrMessage[indexPath.section] as! [String:Any]
        let secAry:[Conversation] = dict[sortedKeys[0]] as! [Conversation]
        
        let dic:Conversation = secAry[indexPath.row]
        if dic.message.sender.id! == getMyUserDefaults(key: MyUserDefaults.UserId) as! Int {
            //Me
            if dic.message.type == "text" {
                let cell = tableView.dequeueReusableCell(withIdentifier:"SendTextCell") as! SendTextCell
                cell.setData(dic: dic)
                return cell
            }
            if dic.message.type == "contact" {
                let cell = tableView.dequeueReusableCell(withIdentifier:"SendContactCell") as! SendContactCell
                cell.setData(dic: dic)
                return cell
            }
            if dic.message.type == "location" || dic.message.type == "image" || dic.message.type == "video" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "SendMediaCell") as! SendMediaCell
                cell.setData(dic: dic)
                cell.viewBubble.addTarget(self, action: #selector(self.mediaCellPressed(_:)), for: UIControlEvents.touchUpInside)
                return cell
            }
            
        }else{
            //Opposite
            if dic.message.type == "text" {
                let cell = tableView.dequeueReusableCell(withIdentifier:"ReceiveTextCell") as! ReceiveTextCell
                cell.setData(dic: dic)
                return cell
            }
            if dic.message.type == "contact" {
                let cell = tableView.dequeueReusableCell(withIdentifier:"ReceiveContactCell") as! ReceiveContactCell
                cell.setData(dic: dic)
                return cell
            }
            if dic.message.type == "location" || dic.message.type == "image" || dic.message.type == "video" {
                let cell = tableView.dequeueReusableCell(withIdentifier: "ReceiveMediaCell") as! ReceiveMediaCell
                cell.setData(dic: dic)
                cell.viewBubble.addTarget(self, action: #selector(self.mediaCellPressed(_:)), for: UIControlEvents.touchUpInside)
                return cell
            }
            
        }
       return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.hideKeyboard()
        let sortedKeys = ((self.arrMessage[indexPath.section] as AnyObject).allKeys as! [String])
        let dict:[String:Any] = self.arrMessage[indexPath.section] as! [String:Any]
        let secAry:[Conversation] = dict[sortedKeys[0]] as! [Conversation]
        
        let dic:Conversation = secAry[indexPath.row]
        if dic.message.type == "contact" {
            let contact:Contact = Contact(fromString: dic.message.body)
            self.showContact(contact: contact)
        }
        
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if (velocity.y > 0){
            if (scrollView.contentOffset.y >= (self.tblChat.contentSize.height - self.tblChat.bounds.size.height))
            {
                NSLog("down")
            }
        }else if (velocity.y < 0) {
            if (scrollView.contentOffset.y <= 50){
                NSLog("up")
                self.callGetChatDataAPI(limit: self.arrConversation.count)
            }
        }
    }
    @objc func mediaCellPressed(_ sender: UIControl) {
        if let dic:Conversation = sender.accessibilityElements?.first as? Conversation{
            if dic.message.type == "location"{
                self.showMap(location: dic.message.body)
            }else if dic.message.type == "image" || dic.message.type == "video"{
                setAttachmentBrowser(conversation: dic)
            }
        }
    }
}
//MARK: -  MWPhotoBrowser Delegate Event
extension SingleChatViewController : MWPhotoBrowserDelegate {
    func setAttachmentBrowser(conversation:Conversation){
        if conversation.message.type == "image"{
            self.arrMWAttachment = []
            let photo:MWPhoto = MWPhoto(url: URL(string: WebURL.imageBaseURL + conversation.message.body!))
            self.arrMWAttachment.append(photo)
            showAttachmentBrowser()
        }else if conversation.message.type == "video"{
            self.arrMWAttachment = []
            let photo:MWPhoto = MWPhoto(videoURL: URL(string: WebURL.imageBaseURL + conversation.message.body!))
            self.arrMWAttachment.append(photo)
            showAttachmentBrowser()
        }
    }
    func showAttachmentBrowser(){
        // Create browser
        let browser:MWPhotoBrowser = MWPhotoBrowser(delegate: self)
        browser.displayActionButton = true
        browser.displayNavArrows = false
        browser.displaySelectionButtons = false
        browser.alwaysShowControls = false
        browser.zoomPhotosToFill = true
        browser.enableGrid = false
        browser.startOnGrid = false
        browser.enableSwipeToDismiss = true
        browser.autoPlayOnAppear = true
        browser.setCurrentPhotoIndex(0)
        isFromMW = true
        
        let nc:UINavigationController = UINavigationController(rootViewController: browser)
        nc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        nc.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        appDelegate.window?.rootViewController?.present(nc, animated: true, completion: nil)
    }
    
    func numberOfPhotos(in photoBrowser: MWPhotoBrowser!) -> UInt {
        return 1
    }
    
    func photoBrowser(_ photoBrowser: MWPhotoBrowser!, photoAt index: UInt) -> MWPhotoProtocol! {
        
        return arrMWAttachment[Int(index)] as MWPhotoProtocol
        
    }
    
    func photoBrowserDidFinishModalPresentation(_ photoBrowser: MWPhotoBrowser!) {
        isFromMW = false
        photoBrowser.dismiss(animated: true, completion: nil)
        
        
    }
}
//MARK: - Button Click Methods
extension SingleChatViewController {
    @IBAction func btnSendCommentPressed(button:UIControl){
        if  txtViewComment.textColor != UIColor.init(red: 141/255.0, green: 140/255.0, blue: 141/255.0, alpha: 1.0) {
            let trimmedString = self.txtViewComment.text.trimmingCharacters(in: .whitespacesAndNewlines)
            if trimmedString.length > 0 {
                self.sendTextMessage(text: trimmedString)
            }
            txtViewComment.text = ""
            self.textViewDidChange(txtViewComment)
        }
    }
    @IBAction func btnAddPressed(button:UIControl){
        self.showOptions()
    }
}
//MARK: - Socket.IO Methods
extension SingleChatViewController {
    func sendLocationMessage(location:String){
        let perameter:[String:Any] = [
            "APPKEY":WebURL.appKey,
            "user_id":getMyUserDefaults(key: MyUserDefaults.UserId),
            "conversation_id":chatListData.id!,
            "body":location,
            "type":"location",
            ]
        SocketIOManager.instance.sendSocketMessage(socketid: "send_message", msgData: perameter)
    }
    func sendContactMessage(dictContact:[String:Any]){
        let text = convertToString(dict: dictContact)
        let perameter:[String:Any] = [
            "APPKEY":WebURL.appKey,
            "user_id":getMyUserDefaults(key: MyUserDefaults.UserId),
            "conversation_id":chatListData.id!,
            "body":text,
            "type":"contact",
            ]
        SocketIOManager.instance.sendSocketMessage(socketid: "send_message", msgData: perameter)
    }
    func sendTextMessage(text:String) {
        self.isTyping = false
        let perameter:[String:Any] = [
            "APPKEY":WebURL.appKey,
            "user_id":getMyUserDefaults(key: MyUserDefaults.UserId),
            "conversation_id":chatListData.id!,
            "body":text,
            "type":"text",
        ]
        SocketIOManager.instance.sendSocketMessage(socketid: "send_message", msgData: perameter)
    }
    func startReceiveSocketMessage(){
        let strResceiveMsg = "send_response_\(chatListData.id!)"
        SocketIOManager.instance.socket.on(strResceiveMsg) {data, ack in
            //print(data)
            if let strData = data.first as? String
            {
                //print(strData)
                let dataNewNow = strData.data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue), allowLossyConversion: false)
                var singleConversationDataResponse:SingleConversationDataResponse
                do{
                    let decode = JSONDecoder()
                    singleConversationDataResponse = try decode.decode(SingleConversationDataResponse.self, from: dataNewNow!)
                    if singleConversationDataResponse.response == "true" {
                        self.loadResponseData(conversationDic: singleConversationDataResponse.conversation)
                    }else{
                        showAlert(msg: singleConversationDataResponse.msg, completion: nil)
                    }
                }catch {
                    print(error)
                }
                
                ack.with("Got your currentAmount", "dude")
            }
            
        }
    }
    func stopReceiveSocketMessage(){
        let strResceiveMsg = "send_response_\(chatListData.id)"
        SocketIOManager.instance.socket.off(strResceiveMsg)
    }
    func startTyping(){
      /*  let perameter = [
            "user_id":String(describing: getMyUserDefaults(key: MyUserDefaults.UserId)),
            "conversation_id": "\(chatListData.id!)",
            ]
        SocketIOManager.instance.startTypingSocketMessage(socketid: "start_typing", msgData: perameter)*/
        
    }
    func stopTyping(){
        /*let perameter = [
            "user_id":String(describing: getMyUserDefaults(key: MyUserDefaults.UserId)),
            "conversation_id": "\(chatListData.id!)",
            ]
        SocketIOManager.instance.stopTypingSocketMessage(socketid: "stop_typing", msgData: perameter)*/
    }
    func getStartTyping(){
     /*  let strStartTyping = "start_receiving_\(chatListData.id)"
        SocketIOManager.instance.socket.on(strStartTyping) {data, ack in
            //print(data)
            if let dic = data.first as? [String:Any] {
                if String(describing:dic["user_id"]!) == String(describing: getMyUserDefaults(key: MyUserDefaults.UserId)){
                    self.showTypingIndicator()
                }
            }
        }*/
    }
    func getStopTyping(){
       /* let strStopTyping = "stop_receiving_\(chatListData.id)"
        SocketIOManager.instance.socket.on(strStopTyping) {data, ack in
            //print(data)
            if let dic = data.first as? [String:Any] {
                if String(describing:dic["user_id"]!) == String(describing: getMyUserDefaults(key: MyUserDefaults.UserId)){
                    self.hideTypingIndicator()
                }
            }
        }*/
        
    }
}
//MARK: - CNContactViewController Delegate Event
extension SingleChatViewController : CNContactViewControllerDelegate {
    func showContact(contact:Contact){
        let contactToAdd = CNMutableContact()
        contactToAdd.givenName = contact.givenName
        contactToAdd.familyName = contact.familyName
        
        let arrPhone = contact.phoneNumber.components(separatedBy: ",")
        
        var arrPhoneLabeledValue:[CNLabeledValue<CNPhoneNumber>] = []
        for phoneNumber in arrPhone {
            let mobileNumber = CNPhoneNumber(stringValue: phoneNumber)
            let mobileValue = CNLabeledValue(label: CNLabelPhoneNumberMobile, value: mobileNumber)
            arrPhoneLabeledValue.append(mobileValue)
            
        }
        contactToAdd.phoneNumbers = arrPhoneLabeledValue
        
        let arrEmail = contact.email.components(separatedBy: ",")
        var arrEmailLabeledValue:[CNLabeledValue<NSString>] = []
        for emailId in arrEmail {
            let email = CNLabeledValue(label: CNLabelHome, value: emailId as NSString)
            arrEmailLabeledValue.append(email)
        }
        contactToAdd.emailAddresses = arrEmailLabeledValue
        
        let contactViewController = CNContactViewController(forNewContact: contactToAdd)
        contactViewController.delegate = self
        let navigationController = UINavigationController(rootViewController: contactViewController)
        self.present(navigationController, animated: true, completion: nil)
    }
    
    func contactViewController(_ viewController: CNContactViewController, didCompleteWith contact: CNContact?) {
        viewController.dismiss(animated: true, completion: nil)
    }
    
}
//MARK: - ContactPicker Delegate Event
extension SingleChatViewController : CNContactPickerDelegate {
    func pickContact(){
        let contactPicker = CNContactPickerViewController()
        contactPicker.delegate = self
        self.present(contactPicker, animated: true, completion: nil)
    }
    
    func contactPicker(_ picker: CNContactPickerViewController, didSelect contact: CNContact) {
        var strPhone = ""
        for number in contact.phoneNumbers {
            if strPhone.count == 0 {
                strPhone = number.value.stringValue
            }else{
                strPhone = strPhone + "," + number.value.stringValue
            }
        }

        var strEmail = ""
        for email in contact.emailAddresses {
            if strEmail.count == 0 {
                strEmail = email.value as String
            }else{
                strEmail = strEmail + "," + (email.value as String)
            }
        }
        let dic:[String:Any] = [
            "givenName":contact.givenName,
            "familyName":contact.familyName,
            "phoneNumber":strPhone,
            "email":strEmail,
            ]
        self.sendContactMessage(dictContact: dic)
    }
    func contactPickerDidCancel(_ picker: CNContactPickerViewController) {
        print("Cancel")
    }
}
//MARK: - Location Picker Delegate Event
extension SingleChatViewController : GMSPlacePickerViewControllerDelegate {
    func showMap(location:String){
        let locations = location.components(separatedBy: ",")
        let coordinate = CLLocationCoordinate2DMake(Double(locations.first!)!,Double(locations.last!)!)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = "Target location"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    func sendLocation(location:String){
        self.sendLocationMessage(location: location)
    }
    func showLocationPicker(){
        let config = GMSPlacePickerConfig(viewport: nil)
        let placePicker = GMSPlacePickerViewController(config: config)
        placePicker.delegate = self
        present(placePicker, animated: true, completion: nil)
    }
    func placePicker(_ viewController: GMSPlacePickerViewController, didPick place: GMSPlace) {
        viewController.dismiss(animated:true) {
                self.sendLocation(location: "\(place.coordinate.latitude),\(place.coordinate.longitude)")
        }
    }
    func placePickerDidCancel(_ viewController: GMSPlacePickerViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    func placePicker(_ viewController: GMSPlacePickerViewController, didFailWithError error: Error) {
        viewController.dismiss(animated: true, completion: nil)
    }
}
//MARK: - Image and Video Picker Delegate Event
extension SingleChatViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func sendImage(image:UIImage){
        let perameter:[String:Any] = [
            "APPKEY":WebURL.appKey,
            "user_id":getMyUserDefaults(key: MyUserDefaults.UserId),
            "conversation_id":chatListData.id!,
            "type":"image",
            ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.callSendImageMessageAPI(perameter: perameter, image: image)
        }
        
    }
    func sendVideo(videoData:Data, thumbImage: UIImage){
        let perameter:[String:Any] = [
            "APPKEY":WebURL.appKey,
            "user_id":getMyUserDefaults(key: MyUserDefaults.UserId),
            "conversation_id":chatListData.id!,
            "type":"video",
            ]
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.callSendVideoMessageAPI(perameter: perameter, videoData: videoData, thumbImage: thumbImage)
        }
    }
    func openCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .camera
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    func photoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    func videoLibrary(){
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self
            myPickerController.sourceType = .photoLibrary
            myPickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
            self.present(myPickerController, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        picker.dismiss(animated: true) {
            // To handle image
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
              // self.imagePickedBlock?(image)
                self.sendImage(image: image)
            } else{
                print("Something went wrong in  image")
            }
            
            // To handle video
            if let videoUrl = info[UIImagePickerControllerMediaURL] as? NSURL{
                print("videourl: ", videoUrl)
                //trying compression of video
                let data = NSData(contentsOf: videoUrl as URL)!
                print("File size before compression: \(Double(data.length / 1048576)) mb")
                self.compressWithSessionStatusFunc(videoUrl)
            }
            else{
                print("Something went wrong in  video")
            }
        }
    }
    func compressVideo(inputURL: URL, outputURL: URL, handler:@escaping (_ exportSession: AVAssetExportSession?)-> Void) {
        let urlAsset = AVURLAsset(url: inputURL, options: nil)
        guard let exportSession = AVAssetExportSession(asset: urlAsset, presetName: AVAssetExportPreset1280x720) else {
            handler(nil)
            
            return
        }
        
        exportSession.outputURL = outputURL
        exportSession.outputFileType = AVFileType.mov
        exportSession.shouldOptimizeForNetworkUse = true
        exportSession.exportAsynchronously { () -> Void in
            handler(exportSession)
        }
    }
    fileprivate func compressWithSessionStatusFunc(_ videoUrl: NSURL) {
        let compressedURL = NSURL.fileURL(withPath: NSTemporaryDirectory() + NSUUID().uuidString + ".MOV")
        compressVideo(inputURL: videoUrl as URL, outputURL: compressedURL) { (exportSession) in
            guard let session = exportSession else {
                return
            }
            
            switch session.status {
            case .completed:
                guard let compressedData = NSData(contentsOf: compressedURL) else {
                    return
                }
                print("File size after compression: \(Double(compressedData.length / 1048576)) mb")
                
                DispatchQueue.main.async {
                    let thumbImage = AVAsset(url:videoUrl as URL)
                    self.sendVideo(videoData: compressedData as Data, thumbImage: thumbImage.videoThumbnail!)
                    //self.videoPickedBlock?(compressedURL as NSURL)
                    
                }
            case .unknown:
                break
            case .waiting:
                break
            case .exporting:
                break
            case .failed:
                break
            case .cancelled:
                break
            }
        }
    }
}
//MARK: - Other Methods
extension SingleChatViewController {
    func showOptions(){
        let alertController = UIAlertController(title: "Options", message: "", preferredStyle:UIAlertControllerStyle.actionSheet)
        alertController.addAction(UIAlertAction(title: "Location", style: UIAlertActionStyle.default, handler: { (action) in
            self.showLocationPicker()
        }))
        alertController.addAction(UIAlertAction(title: "Camera", style: UIAlertActionStyle.default, handler: { (action) in
            self.openCamera()
        }))
        alertController.addAction(UIAlertAction(title: "Video Library", style: UIAlertActionStyle.default, handler: { (action) in
            self.videoLibrary()
        }))
        alertController.addAction(UIAlertAction(title: "Photo Library", style: UIAlertActionStyle.default, handler: { (action) in
            self.photoLibrary()
        }))
        alertController.addAction(UIAlertAction(title: "Contact", style: UIAlertActionStyle.default, handler: { (action) in
            self.pickContact()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            
        }))
        self.present(alertController, animated: true, completion: nil)
    }
    func loadResponseData(conversationDic:Conversation){
        var chatDic:Conversation = conversationDic
        if chatDic.message.sender.id! != getMyUserDefaults(key: MyUserDefaults.UserId) as! Int {
            SocketIOManager.instance.readSocketMessage(socketid: "read_message", userId: String(describing: getMyUserDefaults(key: MyUserDefaults.UserId)), conversationId: chatListData.id)
        }
        if let chatData = self.arrConversation.filter({$0.id == chatDic.id}).first {
            print(chatData.id)
            
        }else{
            chatDic.message.createdAt = getFromUTCTolocalDateHH(strDate: conversationDic.message.createdAt)
            chatDic.message.date = getFromUTCToShortlocalDate(strDate: conversationDic.message.createdAt)
            
            self.arrConversation.append(chatDic)
            self.arrMessage = self.setMessageArray(mainDataArr: self.arrConversation)
        }
        
        let sortedKeys = ((self.arrMessage[self.arrMessage.count-1] as AnyObject).allKeys as! [String])
        let dic:[String:Any] = self.arrMessage[self.arrMessage.count-1] as! [String:Any]
        let secAry:[Conversation] = dic[sortedKeys[0]] as! [Conversation]
        
        if secAry.count == 1 {
            DispatchQueue.main.async {
                self.tblChat.reloadData()
            }
        }else {
            self.tblChat.beginUpdates()
            self.tblChat.insertRows(at: [IndexPath(row: secAry.count-1, section: self.arrMessage.count-1)], with: .none)
            self.tblChat.endUpdates()
            self.tblChat.scrollToRow(at: IndexPath(row: secAry.count-1, section: self.arrMessage.count-1), at: UITableViewScrollPosition.bottom, animated: true)
        }
    }
    func setConversation(arrConversation:[Conversation], isAnimated:Bool){
        //Unique data
        self.arrConversation = self.arrConversation.unique{$0.id}
        
        //Convert date from utc to local
        self.arrConversation = self.arrConversation.map({ dic in
            var dictData = dic
            dictData.message.createdAt = getFromUTCTolocalDateHH(strDate: dic.message.createdAt)
            dictData.message.date = getFromUTCToShortlocalDate(strDate: dic.message.createdAt)
            return dictData
        })
        
        //convert array formate to show data in section
        self.arrMessage = self.setMessageArray(mainDataArr: self.arrConversation)
        DispatchQueue.main.async {
            if isAnimated {
                let previousContentHeight = self.tblChat.contentSize.height
                let previousContentOffset = self.tblChat.contentOffset.y
                self.tblChat.reloadData()
                let currentContentOffset = self.tblChat.contentSize.height - previousContentHeight + previousContentOffset
                self.tblChat.contentOffset = CGPoint(x: 0, y: currentContentOffset)
            }else{
                self.tblChat.reloadData()
                
                let numberOfSections = self.tblChat.numberOfSections
                if numberOfSections > 0 {
                    let numberOfRows = self.tblChat.numberOfRows(inSection: numberOfSections-1)
                    if numberOfRows > 0 {
                        DispatchQueue.main.async {
                            let indexPath = NSIndexPath.init(row: numberOfRows-1, section: numberOfSections-1)
                            self.tblChat.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: isAnimated)
                        }
                        
                    }
                }
                
            }
        }
        
        
    }
    //MARK: - Set Message Array Format Event
    func setMessageArray(mainDataArr: [Conversation]) ->  [Any]{
        
        var sectionWiseAry:[Any] = []
        var dateByDateAry:[[String:Any]] = []
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        
        let mainDataAry:[Conversation] = mainDataArr.sorted(by: { (dictOne, dictTwo) -> Bool in
            
            let date1 = dateFormatter.date(from: dictOne.message.date!)
            let date2 = dateFormatter.date(from: dictOne.message.date!)
            return date1!.compare(date2!) == ComparisonResult.orderedDescending
        })
        sectionWiseAry = mainDataAry.map { $0.message.date! }  //get array of dates only
        
        let set = NSSet(array: sectionWiseAry)
        var arr:[String] =  set.allObjects as! [String] //remove duplicte area
        arr = arr.sorted {
            $0 < $1
        }
        
        for tmpDateString in arr { //for loop equal to exact count of date for which tasks are created, one by one for each area
            var tmpArray1:[Conversation] = []
            tmpArray1 = mainDataArr.filter({$0.message.date! == tmpDateString})
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale(identifier: "en_US")
            tmpArray1 = tmpArray1.sorted(by: { (dictOne, dictTwo) -> Bool in
                let date1 = dateFormatter.date(from: dictOne.message.createdAt)
                let date2 = dateFormatter.date(from: dictTwo.message.createdAt)
                return date1!.compare(date2!) == ComparisonResult.orderedAscending
            })
            if (tmpArray1.count>0) {
                let dictionary1:[String:[Conversation]] = [
                    tmpDateString:tmpArray1,
                    ]
                dateByDateAry.append(dictionary1) //insert that dict into 'tmpSectionArray'
            }
            
        }
        return dateByDateAry
    }
    //MARK: - Typing Indicator Event
    func showTypingIndicator(){
        self.viewTypingIndicatorHeightConstraint.constant = 56.0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        self.viewTypingIndicator.isHidden = false
        self.viewMessageProgress.startAnimation()
        if self.arrMessage.count > 0 {
            let numberOfSections = self.tblChat.numberOfSections
            let numberOfRows = self.tblChat.numberOfRows(inSection: numberOfSections-1)
            if numberOfRows > 0 {
                DispatchQueue.main.async {
                    let indexPath = NSIndexPath.init(row: numberOfRows-1, section: numberOfSections-1)
                    self.tblChat.scrollToRow(at: indexPath as IndexPath, at: UITableViewScrollPosition.bottom, animated: true)
                }
                
            }
            
        }
    }
    func hideTypingIndicator(){
        self.viewTypingIndicatorHeightConstraint.constant = 0.0
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        self.viewTypingIndicator.isHidden = true
        self.viewMessageProgress.stopAnimation()
    }
}
extension SingleChatViewController:UITextViewDelegate {
    // MARK: - UITextView Delegate Event
    func textViewDidChange(_ textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        let mh = min(newSize.height,90)
        let h = max(32,mh)
        txtViewCommentHeightConstraint.constant = h
        self.view.layoutIfNeeded()
        self.isTyping = textView.text != ""
        
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.init(red: 141/255.0, green: 140/255.0, blue: 141/255.0, alpha: 1.0) {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Type a message..."
            textView.textColor = UIColor.init(red: 141/255.0, green: 140/255.0, blue: 141/255.0, alpha: 1.0)
            self.isTyping = false
        }
    }
}
//MARK: - Keyboard Event
extension SingleChatViewController {
    //TODO: - Set Keyboard Observer Event
    func setUpObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(notification:)), name: .UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidHide(notification:)), name: .UIKeyboardDidHide, object: nil)
    }
    //TODO: - Keyboard Show Hide Event
    @objc func keyboardWillShow(notification:NSNotification){
        
        if txtViewComment.textColor == UIColor.init(red: 141/255.0, green: 140/255.0, blue: 141/255.0, alpha: 1.0) {
            txtViewComment.text = nil
            txtViewComment.textColor = UIColor.black
        }else if txtViewComment.textColor == UIColor.black {
            
        }
        if let keyboardRectValue = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardRectValue.height
            setBottomAnimation(value:keyboardHeight)
        }
    }
    @objc func keyboardDidHide(notification:NSNotification){
        setBottomAnimation()
    }
    
    func hideKeyboard(){
        self.view.endEditing(true)
        textViewDidEndEditing(self.txtViewComment)
    }
    func setBottomAnimation(value:CGFloat = 0.0){
        self.viewBottomBottomConstraint.constant = value
        UIView.animate(withDuration: 0.2, animations: {
            self.view.layoutIfNeeded()
        })
    }
}
//MARK: - API Calling
extension SingleChatViewController {
    func callGetChatDataAPI(limit:Int){
        let perameter:[String:Any] = [
            "APPKEY":WebURL.appKey,
            "user_id":getMyUserDefaults(key: MyUserDefaults.UserId),
            "conversation_id":chatListData.id!,
            "limit":limit,
        ]
        apiManager.callChatDataApi(perameter: perameter) { (response) in
            appDelegate.hideLoadingIndicator()
            if response.result.isSuccess {
                var conversationDataResponse:ConversationDataResponse
                do{
                    let decode = JSONDecoder()
                    conversationDataResponse = try decode.decode(ConversationDataResponse.self, from: response.data!)
                    if conversationDataResponse.response == "true" {
                        self.arrConversation += conversationDataResponse.conversation
                        DispatchQueue.main.async {
                            self.setConversation(arrConversation: self.arrConversation, isAnimated: limit != 0)
                        }
                    }else{
                        showAlert(msg: conversationDataResponse.msg, completion: nil)
                    }
                }catch {
                    print(error)
                    showAlert(msg: "Something went wrong, please try again.", completion: nil)
                }
            }else{
                showAlert(msg: "Something went wrong, please try again.", completion: nil)
            }
        }
    }
    func callSendImageMessageAPI(perameter:[String:Any], image:UIImage) {
        appDelegate.showLoadingIndicator(view: self.view)
        apiManager.callSendImageApi(perameter: perameter, image: image) { encodingResult in
            
            switch encodingResult {
            case .success(let upload, _, _):
                upload.validate()
                upload.responseJSON { response in
                    appDelegate.hideLoadingIndicator()
                    if response.result.isSuccess {
                        
                    }else{
                        showAlert(msg: "Something went wrong, please try again.", completion: nil)
                    }
                }
            case .failure(let encodingError):
                print(encodingError)
                appDelegate.hideLoadingIndicator()
                showAlert(msg: "Something went wrong, please try again.", completion: nil)
            }
        }
    }
    func callSendVideoMessageAPI(perameter:[String:Any], videoData:Data, thumbImage:UIImage) {
        appDelegate.showLoadingIndicator(view: self.view)
        apiManager.callSendVideoApi(perameter: perameter, videoData: videoData, thumbImage:thumbImage) { encodingResult in
            switch encodingResult {
            case .success(let upload, _, _):
                upload.validate()
                upload.responseJSON { response in
                    appDelegate.hideLoadingIndicator()
                    if response.result.isSuccess {
                        
                    }else{
                        showAlert(msg: "Something went wrong, please try again.", completion: nil)
                    }
                }
            case .failure(let encodingError):
                appDelegate.hideLoadingIndicator()
                print(encodingError)
                showAlert(msg: "Something went wrong, please try again.", completion: nil)
            }
        }
    }
}
