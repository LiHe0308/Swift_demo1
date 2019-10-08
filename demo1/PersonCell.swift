//
//  PersonCell.swift
//  demo1
//
//  Created by 李贺 on 2019/10/8.
//  Copyright © 2019年 Heli. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {
    
    @IBOutlet weak var nameLab: UILabel!
    @IBOutlet weak var numLab: UILabel!
    
    var model: PersonModel?{
        // didSet 相当于OC的set方法, 外界赋值, 就一定会走该方法
        didSet{
            
            nameLab.text = model?.name
            // num为Int类型, 是必选值, 但是model为可选值, 所以这里要做一下判断, 否则打印的的值就会是optional(num)
            numLab.text = "\(model?.num ?? 0)"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
