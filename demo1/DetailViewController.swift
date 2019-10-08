//
//  DetailViewController.swift
//  demo1
//
//  Created by 李贺 on 2019/10/8.
//  Copyright © 2019年 Heli. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var nameTf: UITextField!
    @IBOutlet weak var numTf: UITextField!
    
    /*
     1. 闭包作为属性的步骤01-声明一个属性, 类型:闭包, 反向传值
     2. 这里要注意: ()->() 外面加括弧和不加括弧的区别.
     3. 加了括弧,代表这个闭包是可选值; 不加括弧代表闭包的返回值是可选值
     */
    var closure: (()->())?
    
    var pModel:PersonModel?{
        
        didSet{
            print(self.view)
            /* 注意:
             1. xib/SB 创建的子控件, 在外界进行赋值时, 会造成崩溃.
             2. 报错: Thread 1: Fatal error: Unexpectedly found nil while unwrapping an Optional value
             3. 原因: vc的 loadView() 是懒加载操作, 通过重写loadView方法, 断点调试, 可以得出, 先走didSet后走loadView(), 也就是说, 父视图的View还没加载, 子视图加载什么.
                    - 由于didSet方法进来后, 子控件view还没有加载, 就为其赋值, 所以会造成崩溃.
             4. 解决:
                    - 01. 在didSet方法的最上面, print(self.view), 强制引用一下, 使其完成加载
                    - 02. 直接在viewDidLoad() 方法中赋值
             */
            self.nameTf.text = pModel?.name;
            self.numTf.text = "\(pModel?.num ?? 0)"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 对为文本框的内容进行监听
        nameTf.addTarget(self, action: #selector(valueChange), for: .editingChanged)
        numTf.addTarget(self, action: #selector(valueChange), for: .editingChanged)
    }
    
    // 输入框监听文字改变
    @objc func valueChange(){
    
        // 设置保存按钮的点击状态: 同时存在才能点击
        navigationItem.rightBarButtonItem?.isEnabled = (nameTf.hasText && numTf.hasText)
    }
    
    // 当两个文本框都有文本内容时, 点击保存数据并且传递到上一页
    @IBAction func saveButtonClick(_ sender: Any) {
        
        pModel?.name = self.nameTf.text
        // 这里的num 为可选值
        let num = Int(self.numTf.text ?? "0")
        pModel?.num = num ?? 0
        // 闭包作为属性的步骤03-执行闭包, 让外界刷新UI
        closure?()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
