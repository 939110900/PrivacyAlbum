//
//  LocalData.swift
//  PrivacyAlbum
//
//  Created by MOKA_MBP on 2018/7/11.
//  Copyright © 2018年 weining. All rights reserved.
//

import UIKit

class LocalData: NSObject {
    
    /*  使用NSUserDefaults对普通数据对象储存   */
    
    /**
     储存
     
     - parameter key:   key
     - parameter value: value
     */
    func setNormalDefault(key:String, value:AnyObject?){
        if value == nil {
            UserDefaults.standard.removeObject(forKey: key)
        }
        else{
            UserDefaults.standard.set(value, forKey: key)
            // 同步
            UserDefaults.standard.synchronize()
        }
    }
    
    /**
     通过对应的key移除储存
     
     - parameter key: 对应key
     */
    func removeNormalUserDefault(key:String?){
        if key != nil {
            UserDefaults.standard.removeObject(forKey: key!)
            UserDefaults.standard.synchronize()
        }
    }
    
    /**
     通过key找到储存的value
     
     - parameter key: key
     
     - returns: AnyObject
     */
    func getNormalDefult(key:String)->String?{
        return UserDefaults.standard.string(forKey: key) as? String
    }

}
