//
//  AppDelegate.swift
//  SocketModule
//
//  Created by Devubha Manek on 11/07/18.
//  Copyright © 2018 Devubha Manek. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import NVActivityIndicatorView
import GooglePlaces
import GoogleMaps

let appDelegate = UIApplication.shared.delegate as! AppDelegate
let apiManager:APIManager = APIManager()
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isLoadingIndicatorOpen:Bool = false
    var loadingIndicator:NVActivityIndicatorView!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        self.setGoogleMapKey()
        self.setLogin()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    //MARK: - Set Google Map Key
    func setGoogleMapKey(){
        GMSPlacesClient.provideAPIKey(googleMapsKeys.googlePlaceKey)
        GMSServices.provideAPIKey(googleMapsKeys.googlePlaceKey)
    }
    //MARK: - Set Login
    func setLogin(){
        self.window?.rootViewController = nil
        if (getMyUserDefaults(key: MyUserDefaults.Login) as! String) == "Login" {
            SocketIOManager.instance.establishConnection()
            let chatListVC:ChatListViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ChatListViewController") as! ChatListViewController
            let nc:UINavigationController = UINavigationController(rootViewController: chatListVC)
            self.window?.rootViewController = nc
            
        }else{
            SocketIOManager.instance.closeConnection()
            let loginVC:LoginViewController = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            let nc:UINavigationController = UINavigationController(rootViewController: loginVC)
            self.window?.rootViewController = nc
            
        }
    }
    //MARK: - Show/Hide Loading Indicator
    func showLoadingIndicator(view : UIView) {
        
        if (isLoadingIndicatorOpen == false) {
            
            view.isUserInteractionEnabled = false
            
            DispatchQueue.global(qos: .background).async {
                
                DispatchQueue.main.async {
                    
                    //Frame
                    let indicatorFrame = CGRect(x: (view.center.x - 40) , y: (view.center.y - 40), width: 80, height: 80)
                    //Color
                    let indicatorColor = UIColor(red: 0/255, green: 12/255, blue: 64/255, alpha: 1.0)
                    //Init
                    self.loadingIndicator = NVActivityIndicatorView(frame: indicatorFrame , type: NVActivityIndicatorView.DEFAULT_TYPE, color: indicatorColor, padding: 10)
                    //Add to superView
                    view.addSubview(self.loadingIndicator)
                    //Start Animating
                    self.loadingIndicator.startAnimating()
                    
                    self.isLoadingIndicatorOpen = true
                }
            }
        }
    }
    
    func hideLoadingIndicator() {
        
        if self.loadingIndicator != nil && isLoadingIndicatorOpen == true {
            DispatchQueue.main.async {
                self.loadingIndicator.superview?.isUserInteractionEnabled = true
                self.loadingIndicator.stopAnimating()
                self.loadingIndicator.removeFromSuperview()
                self.isLoadingIndicatorOpen = false
            }
            
        }
    }
    

}

