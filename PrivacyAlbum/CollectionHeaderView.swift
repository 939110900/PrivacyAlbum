//
//  CollectionHeaderView.swift
//  YYCollectionView
//
//  Created by Domo on 2018/6/27.
//  Copyright © 2018年 知言网络. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    var view = UIView()
    var label = UILabel()
    var button : UIButton?
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.view = UIView.init(frame: CGRect(x:0,y:0, width:self.frame.size.width, height:self.frame.size.height))
        self.addSubview(view)
        
        self.label = UILabel.init(frame: CGRect(x:10, y: 0, width:200, height:self.frame.size.height))
        self.label.backgroundColor = UIColor.blue
        self.addSubview(label)
        
        self.button = UIButton(frame:CGRect(x:100, y:35, width:100, height:20))
        self.button?.setTitle("添加图片", for:.normal) //普通状态下的文字
        self.button?.setTitleColor(UIColor.black, for: .normal) //普通状态下文字的颜色
        self.button?.backgroundColor = UIColor.white
        
        //        self.view.addSubview(button)
        //不传递触摸对象（即点击的按钮）
        self.button?.addTarget(self, action:#selector(tapped), for:.touchUpInside)
        
        self.addSubview(self.button!)
    }
    
    @objc func tapped(){
        print("kkkk")
        print("kkkk")
    }
}
