//
//  LoginViewController.swift
//  SocketModule
//
//  Created by Devubha Manek on 26/07/18.
//  Copyright © 2018 Devubha Manek. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
class LoginViewController: UIViewController {
    //MARK: - Variables
    @IBOutlet var txtEmail:UITextField!
    @IBOutlet var txtPassword:UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //TODO: - Validation
    func validateFields()->Bool {
        if txtEmail.text?.removeWhiteSpace().count == 0 {
            showAlert(msg: "Please enter Email", completion: nil)
            return false
        }
        if txtPassword.text?.removeWhiteSpace().count == 0 {
            showAlert(msg: "Please enter Password", completion: nil)
            return false
        }
        if isValidEmail(testStr: txtEmail.text!.removeWhiteSpace()) == false {
            showAlert(msg: "Please enter valid email address", completion: nil)
            return false
        }
        return true
    }
}

//MARK: - Button pressed Event
extension LoginViewController {
    @IBAction func btnLoginPressed(button:UIButton){
        self.view.endEditing(true)
        if validateFields() {
            callLoginAPI()
        }
    }
}

//MARK: - API Calling
extension LoginViewController {
    func callLoginAPI(){
        appDelegate.showLoadingIndicator(view: self.view)
        let perameter:[String:Any] = [
            "APPKEY":WebURL.appKey,
            "email":self.txtEmail.text!.removeWhiteSpace(),
            "password":self.txtPassword.text!.removeWhiteSpace(),
        ]
        apiManager.callLoginApi(perameter: perameter) { (response) in
            appDelegate.hideLoadingIndicator()
            if response.result.isSuccess {
                if let dicResult:[String:Any] = response.result.value as! [String:Any]? {
                    if getIntFromDictionary(dictionary: dicResult, key: "status") == 1{
                        let dataDic:[String:Any] = getDictionaryFromDictionary(dictionary: dicResult, key:"data")
                        setMyUserDefaults(value: getIntFromDictionary(dictionary: dataDic, key: "id"), key: MyUserDefaults.UserId)
                        setMyUserDefaults(value: dataDic, key: MyUserDefaults.UserData)
                        setMyUserDefaults(value: "Login", key: MyUserDefaults.Login)
                        DispatchQueue.main.async {
                            appDelegate.setLogin()
                        }
                        
                        return
                    }else{
                        showAlert(msg: dicResult["msg"] as! String, completion: nil)
                        return
                    }
                }
                showAlert(msg: "Something went wrong, please try again.", completion: nil)
            }
        }
    }
}
