//
//  ViewController.swift
//  demo1
//
//  Created by 李贺 on 2019/9/28.
//  Copyright © 2019年 Heli. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    // 保存模型的数组
    var dataArray:[PersonModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadData { (result) in
            // 赋值
            self.dataArray = result
            // 刷新UI
            self.tableView.reloadData()
        }
    }
    
    // 模拟网络请求数据
    func loadData(callBack: @escaping ([PersonModel]?)->()){
        
        // 开启子线程
        DispatchQueue.global().async {
            
            // 1. 创建可变数组, 接收数据, 且类型为personModel
            var tempArrayM: [PersonModel] = [PersonModel]()
            // 2. 模拟加载数据的耗时操作
            Thread.sleep(forTimeInterval: 2.0)
            // 3. 模拟数据
            for i in 0..<20 {
                
                let name = "Tom\(i)"
                let num = Int(arc4random() % 20) + i
                let p = PersonModel(dict: ["name": name, "num": num])
                // 4. 添加模型到数组中
                tempArrayM.append(p)
            }
            
            // 回到主线程, 刷新页面
            DispatchQueue.main.async {
                
                // 得到数据的时候, 执行闭包
                callBack(tempArrayM)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 首次进入时候加载 会走该方法 如果强行解包 但是dataArray 是为nil 造成程序崩溃, 所以使用??运算符
        return dataArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // as! 肯定可以转成我想要的类型相当于OC中(PersonCell *)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PersonCell
        cell.model = dataArray![indexPath.row]
        return cell
    }
    
    // 通知视图控制器将要执行segue。 也就是跳转(segue: 转到，接入; 继续)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // 详情控制器
        let detailVc = segue.destination as! DetailViewController
        // 选中点击cell 的indexPath
        let indexPath = self.tableView.indexPathForSelectedRow!
        // 赋值
        detailVc.pModel = self.dataArray![indexPath.row]
        
        // 闭包作为属性的步骤02-实例化闭包
        detailVc.closure = {
            // 刷新
            // 闭包作为属性的步骤04-闭包回调
            self.tableView.reloadData()
        }
    }
}

