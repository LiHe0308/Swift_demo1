//
//  PersonModel.swift
//  demo1
//
//  Created by 李贺 on 2019/10/8.
//  Copyright © 2019年 Heli. All rights reserved.
//

import UIKit

/*
 字典转模型时, 一定要加这句话, 否则转出的模型都为nil或者默认值.
 问题原因: 在Swift4.0之后(包括4.0), 继承于 NSObject的 所有 Swift Class 不会在默认 bridge 到OC, 也就是没有告诉系统 Swift Class内容的存在, 所以会找不到
 解决办法:
 - 在当前类的每个属性前面 添加 @objc 关键字
 - 在当前类的最上方 添加 @objcMembers 关键字
 */

@objcMembers

class PersonModel: NSObject {

    var name: String?
    var num: Int = 0
    
    init(dict: [String: Any]) {
        
        super.init()
        // setValuesForKeys要加在super之后, 因为该方法是NSObject的
        setValuesForKeys(dict)
    }
    
    // 避免组键不对应而引起崩溃
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    // swift中写法 是一个属性 只读属性, 外界直接打印model即可看见详细的属性和对应的value
    override var description: String{
        // keys
        let keys = ["name", "num"]
        return dictionaryWithValues(forKeys: keys).description
    }
}
