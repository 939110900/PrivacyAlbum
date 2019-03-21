//
//  PhotoController.swift
//  PrivacyAlbum
//
//  Created by MOKA_MBP on 2018/10/23.
//  Copyright © 2018年 weining. All rights reserved.
//

import UIKit
import Photos
import SnapKit



class PhotoController: UIViewController ,UICollectionViewDelegate,UICollectionViewDataSource{
    
    
    var imgDatas = [Data?]()
    var ctrNames = String()
    var collectView : UICollectionView?
    let Identifier       = "CollectionViewCell"
    let headerIdentifier = "CollectionHeaderView"
    let footIdentifier   = "CollectionFootView"
    var button : UIButton?
    let statusbarHeight = UIApplication.shared.statusBarFrame.height + 44
    
    typealias blockClosure = (Int,Bool) ->Void
    var didClickItemBlock:blockClosure?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var headView : UIView?
        headView = UIView.init(frame: CGRect(x:0,y:statusbarHeight, width:self.view.frame.size.width, height:100))
        
        headView?.backgroundColor = UIColor.blue
        self.view.addSubview(headView!)
        
        self.tabBarController?.tabBar.isHidden = true
        
        self.button = UIButton(frame:CGRect(x:100, y:35, width:100, height:20))
        self.button?.setTitle("添加图片", for:.normal) //普通状态下的文字
        self.button?.setTitleColor(UIColor.black, for: .normal) //普通状态下文字的颜色
        self.button?.backgroundColor = UIColor.white
        
        //        self.view.addSubview(button)
        //不传递触摸对象（即点击的按钮）
        self.button?.addTarget(self, action:#selector(tapped), for:.touchUpInside)
        
         headView?.addSubview(self.button!)

        self.button?.snp.makeConstraints { (make) -> Void in

            make.width.equalTo(100)
            make.height.equalTo(40)// 链式语法直接定义宽高
            make.center.equalToSuperview()

        }
        
       
        
        let layout = UICollectionViewFlowLayout.init()
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width/2 - 10), height: UIScreen.main.bounds.width/2 - 10)
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        // 设置分区头视图和尾视图宽高
        layout.headerReferenceSize = CGSize.init(width: UIScreen.main.bounds.width, height: 0)
        layout.footerReferenceSize = CGSize.init(width: UIScreen.main.bounds.width, height: 0)
        

        
        self.navigationItem.title = ctrNames
        self.collectView = UICollectionView.init(frame: CGRect(x:0,y:100 + statusbarHeight, width:self.view.frame.size.width, height:self.view.frame.size.height - 100 - statusbarHeight), collectionViewLayout: layout)
        self.collectView?.backgroundColor = UIColor.white
        self.collectView?.delegate = self
        self.collectView?.dataSource = self
        self.view.addSubview(self.collectView!)
        
        // 注册cell
        self.collectView?.register(UINib.init(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: Identifier)
        // 注册headerView
        self.collectView?.register(CollectionHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerIdentifier)
        // 注册footView
        self.collectView?.register(CollectionFootView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: footIdentifier)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        self.button?.isHidden = true
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imgDatas.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:CollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath) as! CollectionViewCell
//        cell.bgView.backgroundColor = armColor()
//        cell.titleLabel.text = String(format:"%ditem",indexPath.row)
        
        cell.imageView.image = UIImage(data: imgDatas[indexPath.row] ?? Data())
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width, height: 0)
    }
    //footer高度
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize.init(width: UIScreen.main.bounds.width, height: 0)
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        //1.取出section的headerView
//        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerIdentifier, for: indexPath) as UICollectionReusableView

//        return headerView
//    }
    
    
    func armColor()->UIColor{
        let red = CGFloat(arc4random()%256)/255.0
        let green = CGFloat(arc4random()%256)/255.0
        let blue = CGFloat(arc4random()%256)/255.0
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    //实现UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        //某个Cell被选择的事件处理
        print("Hello")
        
        if didClickItemBlock != nil {
            didClickItemBlock!(imgDatas.count,true)
        }
        
        
        
    }
    
    @objc func tapped(){
//        imgDatas.removeAll()
        HsuPhotosManager.share.takePhotos(1, true, true) { (datas) in
            self.imgDatas.append(contentsOf: datas)
            DispatchQueue.main.async {
                self.collectView?.reloadData()
            }
        }
    }
    
    
    
    
}
