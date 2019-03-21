//
//  Home_VC.swift
//  LBTabBar
//
//  Created by chenlei_mac on 15/8/25.
//  Copyright (c) 2015年 Bison. All rights reserved.
//

import UIKit

class Home_VC:
    
 
 UIViewController,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate {
    
    var ctrNames:[String]?
    var tableView : UITableView?
    var localOp : LocalData?
    var imgDatas = [Data?]()
    var button : UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "首页"
        
        //self.ctrNames = ["1","2","3","4","5","6","7","8","9","0"]
        self.ctrNames = []
        self.localOp = LocalData()
        self.localOp?.setNormalDefault(key: "1", value: "名字" as AnyObject)
        var i = 1
        while true {
            let str = String(i)
            let kkk = self.localOp?.getNormalDefult(key: str)
            if kkk == nil{
                break;
            } else {
                self.ctrNames?.append(kkk as! String)
            }
            i = i + 1;
        }
        self.tableView = UITableView.init(frame: self.view.frame, style: UITableViewStyle.plain)
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        self.tableView?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.view.addSubview(self.tableView!)
        self.button = UIButton(frame:CGRect(x:15, y:35, width:20, height:20))
        self.button?.setTitle("+", for:.normal) //普通状态下的文字
        self.button?.setTitleColor(UIColor.white, for: .normal) //普通状态下文字的颜色
        self.button?.backgroundColor = UIColor.orange
        self.navigationController?.view.addSubview(self.button!)
//        self.view.addSubview(button)
        //不传递触摸对象（即点击的按钮）
        self.button?.addTarget(self, action:#selector(tapped), for:.touchUpInside)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.button?.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @objc func tapped(){
        let alertController = UIAlertController(title: "添加相册",
                                                message: "请输入相册名称", preferredStyle: .alert)
        alertController.addTextField {
            (textField: UITextField!) -> Void in
            textField.placeholder = "相册名称"
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .default, handler: {
            action in
            //也可以用下标的形式获取textField let login = alertController.textFields![0]
            let name = alertController.textFields!.first!
            
            self.ctrNames?.append(name.text!)
//            var stri = String(t)
            let i = self.ctrNames?.count
            let stri = "\(i!)"
            self.localOp?.setNormalDefault(key: stri, value: name.text! as AnyObject)
            
            self.tableView?.reloadData()
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.ctrNames?.count)!
    }
    //创建各单元格显示内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let iderntify:String = "swiftCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: iderntify)
        if(cell == nil){
            cell=UITableViewCell(style: UITableViewCellStyle.default
                , reuseIdentifier: iderntify);
            
        }
        cell?.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        cell?.textLabel?.text =  self.ctrNames?[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView?.deselectRow(at: indexPath, animated: true)
        print("你选中了\(indexPath)" )
        
        let photoView = PhotoController()
        photoView.ctrNames = (self.ctrNames?[indexPath.row])!
        photoView.didClickItemBlock = { (index,tapAnimation) in
            
             print("1111")
             print("1111")
             print("1111")
             print("1111")
             print("1111")
        }
        
        
        
        self.button?.isHidden = true
        //跳转
        self.navigationController?.pushViewController(photoView , animated: true)
        
//        imgDatas.removeAll()
//        HsuPhotosManager.share.takePhotos(7, true, true) { (datas) in
//            self.imgDatas.append(contentsOf: datas)
//        }
    }
    

}
