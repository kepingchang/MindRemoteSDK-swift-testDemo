//
//  ViewController.swift
//  swiftsdkDemo
//
//  Created by KKING on 2017/8/2.
//  Copyright © 2017年 KKING. All rights reserved.
//

import UIKit
import MindSDKSwift

public let MindSDK = MDManager.sharedInstance


class ViewController: UIViewController {
    
    //3 获取skillList--
    @IBAction func test31(_ sender: Any) {
        MindSDK.robot?.md_getSkillList()
    }
    
    @IBAction func test32(_ sender: Any) {
        MindSDK.robot?.md_connectSkill("dance")
    }
    
    @IBAction func test33(_ sender: Any) {
        MindSDK.robot?.md_disconnectSkill("dance")
    }
    
    @IBAction func test34(_ sender: Any) {
        MindSDK.robot?.md_stopSkill("dance")
    }
    
    //Rock and Run
    @IBAction func test35(_ sender: Any) {
        MindSDK.robot?.md_deleteSkill("28518ebf")
    }
    
    @IBAction func test36(_ sender: Any) {
        MindSDK.robot?.md_downloadSkill("28518ebf", skillName: "Rock and Run", skillVersion: "1.0.2", downloadURL: "https://cdn-file.vincross.com/5901c686cb37cb00060017e8")
    }
    
    @IBAction func test37(_ sender: Any) {
        MindSDK.robot?.md_pauseInstallSkill("28518ebf")
    }
    
    
    //4 发送应用数据
    @IBAction func test41(_ sender: Any) {
        MindSDK.robot?.md_sendSkillData("", skillID: "28518ebf")
    }
    
    
    //5 查看日志级别
    @IBAction func test51(_ sender: Any) {
        MindSDK.robot?.md_getLogLevel()
    }
    
    @IBAction func test52(_ sender: Any) {
        MindSDK.robot?.md_setLogLevel(level: "info")
    }
    
    @IBAction func test53(_ sender: Any) {
        MindSDK.robot?.md_sendLog(log: "123")
    }
    
    
    //6 修改昵称--
    @IBAction func test61(_ sender: Any) {
        MindSDK.robot?.md_modifyNickname(nickname: "SDK测试")
    }
    
    @IBAction func test62(_ sender: Any) {
        MindSDK.robot?.md_getRobotInfo()
    }
    
    @IBAction func test63(_ sender: Any) {
        MindSDK.robot?.md_upgradeRobot()
    }
    
    @IBAction func test64(_ sender: Any) {
        MindSDK.robot?.md_getMindInfo()
    }
    
    
    //7 添加可信用户--
    @IBAction func test71(_ sender: Any) {
        let dict = [
            "firstName": "",
            "lastName": "",
            "userhash": ""
        ]
        do {
            let dictData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            MindSDK.robot?.md_addTrustUser(MDUserInfo(json: JSON(dictData)))
        }catch let error {
            DLog(error)
        }
    }
    
    @IBAction func test72(_ sender: Any) {
        let dict = [
            "firstName": "",
            "lastName": "",
            "userhash": ""
        ]
        do {
            let dictData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            MindSDK.robot?.md_removeTrustUser(MDUserInfo(json: JSON(dictData)))
        }catch let error {
            DLog(error)
        }
    }
    
    @IBAction func test73(_ sender: Any) {
        MindSDK.robot?.md_getTrustUserList()
    }
    
    @IBAction func test74(_ sender: Any) {
        MindSDK.robot?.md_transferOwner("", token:"")
    }
    
    
    
    //8 本地SSID列表
    @IBAction func test81(_ sender: Any) {
        MindSDK.robot?.md_wifiList()
    }
    
    @IBAction func test82(_ sender: Any) {
        MindSDK.robot?.md_scanWifi()
    }
    
    @IBAction func test83(_ sender: Any) {
        let dict = [
            "ssid": "",
            "psk": "",
            ] as [String : Any]
        
        do {
            let dictData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let jsonData = MindSDKSwift.JSON(data: dictData)
            let wifiInfo = MDWifiInfo(json: jsonData)
            MindSDK.robot?.md_addOrChangeWifi(wifiInfo)
        }catch let error {
            DLog(error)
        }
    }
    
    @IBAction func test84(_ sender: Any) {
        MindSDK.robot?.md_removeWifi("ssid")
    }
    
    
    //9 切换到wifi--
    @IBAction func test91(_ sender: Any) {
        MindSDK.robot?.md_switch(toWifi: MDWifiInfo(json: JSON()))
    }
    
    @IBAction func test92(_ sender: Any) {
        MindSDK.robot?.md_changeToAP()
    }
    
    
    //10 获取设置语言
    @IBAction func test101(_ sender: Any) {
        MindSDK.robot?.md_getLanguage()
    }
    
    @IBAction func test102(_ sender: Any) {
        MindSDK.robot?.md_setRobotLanguage("")
    }
    
    
    //11 关机-重启--
    @IBAction func test111(_ sender: Any) {
        MindSDK.robot?.md_powerOff()
    }
    
    @IBAction func test112(_ sender: Any) {
        MindSDK.robot?.md_reboot()
    }
    
    @IBAction func test113(_ sender: Any) {
        MindSDK.robot?.md_openDeveloperMode()
    }
    
    @IBAction func test114(_ sender: Any) {
        MindSDK.robot?.md_ignoreSystemRecoveryRemind()
    }
    
    @IBAction func test115(_ sender: Any) {
        MindSDK.robot?.md_cleanSystemModifications()
    }
    
    @IBAction func test116(_ sender: Any) {
        MindSDK.robot?.md_cleanApplicationData()
    }
    
    @IBAction func test1110(_ sender: Any) {
        MindSDK.robot?.md_closeUploadMindLog()
    }
    
    @IBAction func test1112(_ sender: Any) {
        MindSDK.robot?.md_openUploadMindLog()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MindSDK.accessToken = "898da00a5da84cb6aef305d62bf3c048"
        MindSDK.userhash = "470ff4b396d04176ac1ac39ed236d94e"
        
        if MindSDK.md_checkApMode() {
            
            MindSDK.md_scanUDPRobot(apMode: true)
            MindSDK.apRobotsHandle = {
                MindSDK.md_createRobot(with: $0.first!)
                DispatchQueue.main.async {
                    MindSDK.robot?.md_connect(handle: {
                        DLog($0)
                    })
                }
            }
        }else {
            
            do {
                let dict =  [
                    "nickname":"HEXA-App",
                    "sn":"101190112014"
                    ] as [String : Any]
                
                let data = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                
                let robotInfo = MDRobotInfo(json: JSON(data: data))
                
                MindSDK.md_createRobot(with: robotInfo)
                MindSDK.robot?.md_connect(handle: { (status) in
                    DLog(status)
                })
            }catch let error {
                DLog(error)
            }
            
        }
        
    }
    
}



//private var bKey: Void?
//
//extension ViewController {
//
//    var a = false
//
//
//
//    var b: Bool {
//        get {
//            return getAssociateValue(with: &bKey)!
//        }
//        set {
//            setAssociateValue(newValue, key: &bKey)
//        }
//    }
//}
//
//
//
//
//public extension NSObject {
//
//    public func setAssociateValue(_ value: Any!, key: UnsafeRawPointer!) {
//        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//    }
//
//    public func setAssociateWeakValue(_ value: Any!, key: UnsafeRawPointer!) {
//        objc_setAssociatedObject(self, key, value, .OBJC_ASSOCIATION_ASSIGN)
//    }
//
//    public func getAssociateValue<T>(with key: UnsafeRawPointer!) -> T? {
//        return objc_getAssociatedObject(self, key) as? T
//    }
//
//    public func removeAssociatedValues() {
//        objc_removeAssociatedObjects(self)
//    }
//}




