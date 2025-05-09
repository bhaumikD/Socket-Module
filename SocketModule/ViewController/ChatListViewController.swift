//
//  ChatListViewController.swift
//  SocketModule
//
//  Created by Devubha Manek on 11/07/18.
//  Copyright © 2018 Devubha Manek. All rights reserved.
//

import UIKit
//MARK: - ChatList Cell
class ChatListCell:UITableViewCell {
    @IBOutlet var lblNameBadge:UILabel!
    @IBOutlet var lblName:UILabel!
    @IBOutlet var lblRecentMessage:UILabel!
    @IBOutlet var lblTime:UILabel!
    @IBOutlet var lblUnreadCount:UILabel!
    @IBOutlet var imgProfile:UIImageView!
    
    func setChatData(chatData:ChatListData){
        self.lblName.text = chatData.withUser.user.name.capitalized
        self.lblNameBadge.text = String(describing:chatData.withUser.user.name.first!).uppercased()
        self.lblUnreadCount.setNotificationCounter(counter: String(describing:chatData.unreadMessagesCount!))
        self.lblTime.text = ""
        self.lblRecentMessage.text = ""
        if chatData.lastMessage != nil {
            self.lblTime.text = getFromUTCToShortlocalDateHH(strDate: chatData.lastMessage.message.createdAt)
            self.lblRecentMessage.text = chatData.lastMessage.message.body
            if chatData.lastMessage.message.type != "text" {
                self.lblRecentMessage.text = chatData.lastMessage.message.type.capitalized
            }
        }
        self.selectionStyle = .none
    }
}
//MARK: - ChatListViewController
class ChatListViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet var tblChatList:UITableView!
    var refreshControl: UIRefreshControl!
    var arrChatData:[ChatListData] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- Initialisation
    func initData(){
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(self.pullToReferesh), for: UIControlEvents.valueChanged)
        tblChatList.addSubview(refreshControl)
        self.tblChatList.separatorColor = UIColor.clear
        appDelegate.showLoadingIndicator(view: self.view)
        self.callGetChatListDataAPI()
    }

}
//MARK: - Button pressed Event
extension ChatListViewController {
    @IBAction func btnLogoutPressed(button:UIBarButtonItem){
        self.view.endEditing(true)
        clearMyUserDefaluts()
        DispatchQueue.main.async {
                appDelegate.setLogin()
        }
        
    }
}
//MARK: - Other Methods
extension ChatListViewController{
    @objc func pullToReferesh() {
        self.callGetChatListDataAPI()
    }
}
//MARK: - UITableView DataSource & Delegate
extension ChatListViewController:UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrChatData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:ChatListCell = tableView.dequeueReusableCell(withIdentifier: "ChatListCell", for: indexPath) as! ChatListCell
        cell.setChatData(chatData: arrChatData[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let singleChatVC = self.storyboard?.instantiateViewController(withIdentifier: "SingleChatViewController") as! SingleChatViewController
        singleChatVC.chatListData = arrChatData[indexPath.row]
        singleChatVC.delegate = self
        self.navigationController?.pushViewController(singleChatVC, animated: true)
    }
}
//MARK: - SingleChatViewController Delegate Event
extension ChatListViewController:SingleChatViewControllerDelegate{
    func singleChatViewControllerLastMessage(chatListData: ChatListData) {
        arrChatData = arrChatData.map({ chatListDataDic in
            if chatListDataDic.id == chatListData.id {
                return chatListData
            }
            return chatListDataDic
        })
        DispatchQueue.main.async {
            self.tblChatList.reloadData()
        }
    }
}
//MARK: - API Calling
extension ChatListViewController {
    func callGetChatListDataAPI(){
        let perameter:[String:Any] = [
            "APPKEY":WebURL.appKey,
            "user_id":getMyUserDefaults(key: MyUserDefaults.UserId)
        ]
        apiManager.callChatListApi(perameter: perameter) { (response) in
            self.refreshControl.endRefreshing()
            appDelegate.hideLoadingIndicator()
            if response.result.isSuccess {
                var chatListDataResponse:ChatListDataResponse
                do{
                    let decode = JSONDecoder()
                    chatListDataResponse = try decode.decode(ChatListDataResponse.self, from: response.data!)
                    if chatListDataResponse.response == "true" {
                        self.arrChatData = chatListDataResponse.chatListData
                        DispatchQueue.main.async {
                            self.tblChatList.reloadData()
                        }
                    }else{
                        showAlert(msg: chatListDataResponse.msg, completion: nil)
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
}
