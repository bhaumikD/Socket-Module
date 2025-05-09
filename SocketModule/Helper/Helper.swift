//
//  Helper.swift
//  SocketModule
//
//  Created by Devubha Manek on 11/07/18.
//  Copyright © 2018 Devubha Manek. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import SystemConfiguration
import Photos

//MARK: - Google Maps Key
struct googleMapsKeys {
    static let googlePlaceKey = "AIzaSyA_phJ0PUxzb3bRIwqrRH3d-dhmp_kpNk0"
    
}
//MARK: - Web Services Constant
struct WebURL {
    static let appKey:String = "da85d87b84495e473sk4srrh6anebc7247"
    static let baseURL:String = "http://199.250.201.83/~mobile/chatmodule/api/"
    static let imageBaseURL:String = "http://199.250.201.83/~mobile/chatmodule/upload/"

    static let login:String = WebURL.baseURL + "login"
    static let register:String = WebURL.baseURL + "register"
    static let getChatList:String = WebURL.baseURL + "get-chat"
    static let readMessage:String = WebURL.baseURL + ""
    static let getConversationChat:String = WebURL.baseURL + "get-single-conversation"
    static let sendMsg:String = WebURL.baseURL + "send-message"
}
//MARK: - MyUserDefaults Constant
struct MyUserDefaults {
    static let UserId:String = "UserId"
    static let UserData:String = "UserData"
    static let Login:String = "Login"
}
//MARK: - Get/Set UserDefaults
func setMyUserDefaults(value:Any, key:String){
    DispatchQueue.main.async {
        UserDefaults.standard.set(value, forKey: key)
        UserDefaults.standard.synchronize()
    }
    
}
func getMyUserDefaults(key:String)->Any{
    return UserDefaults.standard.value(forKey: key) ?? ""
}
func clearMyUserDefaluts(){
    let appDomain = Bundle.main.bundleIdentifier!
    UserDefaults.standard.removePersistentDomain(forName: appDomain)
    UserDefaults.standard.synchronize()
}
func removeMyUserDefaults(key:String){
    UserDefaults.standard.removeObject(forKey: key)
}

//MARK: - Show Alert
func showAlert(msg:String, completion:((Bool)->())?){
    let alert = UIAlertController(title: "Chat", message: msg, preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
        if completion != nil {
            completion!(true)
        }
    }))
    
    UIApplication.topViewController()?.present(alert, animated: true, completion: nil)
}
//MARK: - Check internet connection event
func isConnectedToNetwork() -> Bool {
    
    var zeroAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
    
}
//Validate Email
func isValidEmail(testStr:String) -> Bool {
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailTest.evaluate(with: testStr)
}
//Get UTC to Local time
func getFromUTCTolocalDateHH(strDate:String)->String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let timeZone = TimeZone.init(identifier: "UTC")
    dateFormatter.timeZone = timeZone
    dateFormatter.locale = Locale(identifier: "en_US")
    //dateFormatter.locale = Locale(identifier: "en_US")
    let date:Date = dateFormatter.date(from:strDate)!
    dateFormatter.timeZone = TimeZone.current
    return dateFormatter.string(from: date)
}

func getFromUTCToShortlocalDate(strDate:String)->String{
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let timeZone = TimeZone.init(identifier: "UTC")
    dateFormatter.timeZone = timeZone
    dateFormatter.locale = Locale(identifier: "en_US")
    let date:Date = dateFormatter.date(from:strDate)!
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "en_US")
    return dateFormatter.string(from: date)
}

func getFromUTCToShortlocalDateHH(strDate:String)->String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    let timeZone = TimeZone.init(identifier: "UTC")
    dateFormatter.timeZone = timeZone
    dateFormatter.locale = Locale(identifier: "en_US")
    let date:Date = dateFormatter.date(from:strDate)!
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.dateFormat = "hh:mma"
    dateFormatter.locale = Locale(identifier: "en_US")
    return dateFormatter.string(from: date)
}
func getShortTimeHH(strDate:String)->String{
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    formatter.locale = Locale(identifier: "en_US")
    let timeString = strDate
    let date = formatter.date(from: timeString)!
    formatter.dateFormat = "hh:mma"
    formatter.locale = Locale(identifier: "en_US")
    return formatter.string(from: date)
}
func getDaysDifference(date:String) -> Int{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale(identifier: "en_US")
    let firstDate = dateFormatter.date(from: date)
    let secondDate = dateFormatter.date(from: dateFormatter.string(from: Date.init()))
    let calendar = NSCalendar.current
    
    // Replace the hour (time) of both dates with 00:00
    let dt1 = calendar.startOfDay(for: firstDate!)
    let dt2 = calendar.startOfDay(for: secondDate!)
    
    let components = calendar.dateComponents([.day], from: dt1, to: dt2)
    return components.day!
}
//MARK: - Convert Dictionary to String
func convertToString(dict: [String: Any]) -> String {
    let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: [])
    let jsonString = String(data: jsonData!, encoding: .utf8)
    return jsonString ?? ""
}
//MARK: - Convert String to Dictionary
func convertToDictionary(text: String) -> [String: Any]? {
    if let data = text.data(using: .utf8) {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
    }
    return [:]
}
//MARK: - AVAsset Extension
extension AVAsset{
    var videoThumbnail:UIImage?{
        let assetImageGenerator = AVAssetImageGenerator(asset: self)
        assetImageGenerator.appliesPreferredTrackTransform = true
        let durationSeconds = CMTimeGetSeconds(self.duration)
        
        //let time : CMTime = CMTimeMakeWithSeconds(durationSeconds/5.0, 600)
        let time = CMTime(seconds: durationSeconds/5.0, preferredTimescale: 600)
        //        let time = CMTime(seconds: 5, preferredTimescale: 60)
        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            //  let thumbNail = UIImage.init(cgImage: imageRef)
            print("Video Thumbnail genertated successfuly")
            return UIImage(cgImage: imageRef)
        } catch {
            print("error getting thumbnail video")
            let thumbNail = UIImage(named:"placeholder")
            return thumbNail
        }
    }
}
//MARK: - Array Extention
extension Array {
    func unique<T:Hashable>(map: ((Element) -> (T)))  -> [Element] {
        var set = Set<T>() //the unique list kept in a Set for fast retrieval
        var arrayOrdered = [Element]() //keeping the unique list of elements but ordered
        for value in self {
            if !set.contains(map(value)) {
                set.insert(map(value))
                arrayOrdered.append(value)
            }
        }
        
        return arrayOrdered
    }
}
//MARK: - UIApplication Extension
extension UIApplication {
    class func topViewController(viewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = viewController as? UINavigationController {
            return topViewController(viewController: nav.visibleViewController)
        }
        if let tab = viewController as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(viewController: selected)
            }
        }
        if let presented = viewController?.presentedViewController {
            return topViewController(viewController: presented)
        }
        return viewController
    }
}
//MARK: - UIView Extension
extension UIView {
    
    //MARK: - IBInspectable
    //Set Corner Radious
    @IBInspectable var cornerRadius:CGFloat {
        set {
            self.layer.cornerRadius = newValue
        }
        get {
            return self.layer.cornerRadius
        }
    }
    //Set Round
    @IBInspectable var Round:Bool {
        set {
            self.layer.cornerRadius = self.frame.size.height / 2.0
        }
        get {
            return self.layer.cornerRadius == self.frame.size.height / 2.0
        }
    }
    //Set Border Color
    @IBInspectable var borderColor:UIColor {
        set {
            self.layer.borderColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
    }
    //Set Border Width
    @IBInspectable var borderWidth:CGFloat {
        set {
            self.layer.borderWidth = newValue
        }
        get {
            return self.layer.borderWidth
        }
    }
    
    //Set Shadow to view
    @IBInspectable var ShdwColor:UIColor {
        set {
            self.layer.shadowColor = newValue.cgColor
        }
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
    }
    @IBInspectable var ShdwOffset:CGSize  {
        set {
            self.layer.shadowOffset = newValue
        }
        get {
            return self.layer.shadowOffset
        }
    }
    @IBInspectable var ShdwOpacity:CGFloat {
        set {
            self.layer.shadowOpacity = Float(newValue)
        }
        get {
            return CGFloat(self.layer.shadowOpacity)
        }
    }
    
    @IBInspectable var ShdwRadius:CGFloat {
        set {
            self.layer.shadowRadius = newValue
        }
        get {
            return self.layer.shadowRadius
        }
    }
    
    func setBottomCurve(){
        let offset = CGFloat(self.frame.size.height/2)
        let bounds = self.bounds
        let rectBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y  , width:  bounds.size.width, height: bounds.size.height / 2)
        let rectPath = UIBezierPath(rect: rectBounds)
        let ovalBounds = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        self.layer.mask = maskLayer
    }
    func setTopCurve(){
        let offset = CGFloat(self.frame.size.height/4)
        let bounds = self.bounds
        let rectBounds = CGRect(x: bounds.origin.x, y: bounds.origin.y + bounds.size.height/2  , width:  bounds.size.width, height: bounds.size.height / 2)
        let rectPath = UIBezierPath(rect: rectBounds)
        let ovalBounds = CGRect(x: bounds.origin.x - offset / 2, y: bounds.origin.y, width: bounds.size.width + offset, height: bounds.size.height)
        let ovalPath = UIBezierPath(ovalIn: ovalBounds)
        rectPath.append(ovalPath)
        
        let maskLayer = CAShapeLayer.init()
        maskLayer.frame = bounds
        maskLayer.path = rectPath.cgPath
        self.layer.mask = maskLayer
    }
    //Set Shadow in View
    func addShadowView(width:CGFloat=0.2, height:CGFloat=0.2, Opacidade:Float=0.7, maskToBounds:Bool=false, radius:CGFloat=0.5){
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = Opacidade
        self.layer.masksToBounds = maskToBounds
    }
    struct NLInnerShadowDirection: OptionSet {
        let rawValue: Int
        
        static let None = NLInnerShadowDirection(rawValue: 0)
        static let Left = NLInnerShadowDirection(rawValue: 1 << 0)
        static let Right = NLInnerShadowDirection(rawValue: 1 << 1)
        static let Top = NLInnerShadowDirection(rawValue: 1 << 2)
        static let Bottom = NLInnerShadowDirection(rawValue: 1 << 3)
        static let All = NLInnerShadowDirection(rawValue: 15)
    }
    
    func removeInnerShadow() {
        for view in self.subviews {
            if (view.tag == 2639) {
                view.removeFromSuperview()
                break
            }
        }
    }
    
    func addInnerShadow() {
        let c = UIColor()
        let color = c.withAlphaComponent(0.5)
        
        self.addInnerShadowWithRadius(radius: 3.0, color: color, inDirection: NLInnerShadowDirection.All)
    }
    
    func addInnerShadowWithRadius(radius: CGFloat, andAlpha: CGFloat) {
        let c = UIColor()
        let color = c.withAlphaComponent(alpha)
        
        self.addInnerShadowWithRadius(radius: radius, color: color, inDirection: NLInnerShadowDirection.All)
    }
    
    func addInnerShadowWithRadius(radius: CGFloat, andColor: UIColor) {
        self.addInnerShadowWithRadius(radius: radius, color: andColor, inDirection: NLInnerShadowDirection.All)
    }
    
    func addInnerShadowWithRadius(radius: CGFloat, color: UIColor, inDirection: NLInnerShadowDirection) {
        self.removeInnerShadow()
        
        let shadowView = self.createShadowViewWithRadius(radius: radius, andColor: color, direction: inDirection)
        
        self.addSubview(shadowView)
    }
    
    func createShadowViewWithRadius(radius: CGFloat, andColor: UIColor, direction: NLInnerShadowDirection) -> UIView {
        let shadowView = UIView(frame: CGRect(x: 0,y: 0,width: self.bounds.size.width,height: self.bounds.size.height))
        shadowView.backgroundColor = UIColor.clear
        shadowView.tag = 2639
        
        let colorsArray: Array = [ andColor.cgColor, UIColor.clear.cgColor ]
        
        if direction.contains(.Top) {
            let xOffset: CGFloat = 0.0
            let topWidth = self.bounds.size.width
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.startPoint = CGPoint(x:0.5,y: 0.0)
            shadow.endPoint = CGPoint(x:0.5,y: 1.0)
            shadow.frame = CGRect(x: xOffset,y: 0,width: topWidth,height: radius)
            shadowView.layer.insertSublayer(shadow, at: 0)
        }
        
        if direction.contains(.Bottom) {
            let xOffset: CGFloat = 0.0
            let bottomWidth = self.bounds.size.width
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.startPoint = CGPoint(x:0.5,y: 1.0)
            shadow.endPoint = CGPoint(x:0.5,y: 0.0)
            shadow.frame = CGRect(x:xOffset,y: self.bounds.size.height - radius, width: bottomWidth,height: radius)
            shadowView.layer.insertSublayer(shadow, at: 0)
        }
        
        if direction.contains(.Left) {
            let yOffset: CGFloat = 0.0
            let leftHeight = self.bounds.size.height
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.frame = CGRect(x:0,y: yOffset,width: radius,height: leftHeight)
            shadow.startPoint = CGPoint(x:0.0,y: 0.5)
            shadow.endPoint = CGPoint(x:1.0,y: 0.5)
            shadowView.layer.insertSublayer(shadow, at: 0)
        }
        
        if direction.contains(.Right) {
            let yOffset: CGFloat = 0.0
            let rightHeight = self.bounds.size.height
            
            let shadow = CAGradientLayer()
            shadow.colors = colorsArray
            shadow.frame = CGRect(x:self.bounds.size.width - radius,y: yOffset,width: radius,height: rightHeight)
            shadow.startPoint = CGPoint(x:1.0,y: 0.5)
            shadow.endPoint = CGPoint(x:0.0,y: 0.5)
            shadowView.layer.insertSublayer(shadow, at: 0)
        }
        return shadowView
    }
    
    func addDashedLine(strokeColor: UIColor, lineWidth: CGFloat) {
        self.layoutIfNeeded()
        backgroundColor = .clear
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.name = "DashedTopLine"
        shapeLayer.bounds = bounds
        shapeLayer.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineDashPattern = [4, 4]
        
        let path = CGMutablePath()
        path.move(to: CGPoint.zero)
        path.addLine(to: CGPoint(x: frame.width, y: 0))
        shapeLayer.path = path
        
        layer.addSublayer(shapeLayer)
    }
    func getContentHeight() -> CGFloat{
        
        var height: CGFloat = 0
        for someView in self.subviews {
            let aView = someView
            let newHeight = aView.frame.origin.y + aView.frame.height
            height = max(height, newHeight)
        }
        
        return height
    }
    
    func roundBubbleCorners(_ corners: UIRectCorner) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: 18, height: 18))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
    //Shake Animation
    func shake(count : Float? = nil,for duration : TimeInterval? = nil,withTranslation translation : Float? = nil) {
        let animation : CABasicAnimation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        animation.repeatCount = count ?? 1
        animation.duration = (duration ?? 0.2)/TimeInterval(animation.repeatCount)
        animation.autoreverses = true
        animation.byValue = translation ?? +7
        layer.add(animation, forKey: "shake")
    }
}

//MARK: - UILabel Extension
extension UILabel {
    //Set notification counter with dynamic width calculate
    func setNotificationCounter(counter: String) {
        if counter.length == 0 || counter == "0" {
            self.isHidden = true
        }
        else {
            self.isHidden = false
            let strCounter:String = ":\(counter)|"
            
            self.clipsToBounds = true
            self.layer.cornerRadius = self.frame.size.height / 2.0
            
            let string_to_color1 = ":"
            let range1 = (strCounter as NSString).range(of: string_to_color1)
            let attributedString1 = NSMutableAttributedString(string:strCounter)
            attributedString1.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.clear , range: range1)
            
            let string_to_color2 = "|"
            let range2 = (strCounter as NSString).range(of: string_to_color2)
            attributedString1.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.clear , range: range2)
            self.attributedText = attributedString1
        }
    }
    //Get notification counter
    func getNotificationCounter() -> String {
        if self.text?.length == 0 {
            return ""
        }
        else {
            var strCounter = self.text
            strCounter = strCounter?.replacingOccurrences(of: ":", with: "")
            strCounter = strCounter?.replacingOccurrences(of: "|", with: "")
            return strCounter!
        }
    }
}
