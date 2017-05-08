//
//  JY_BannerView.swift
//  依赖库：SnapKit
//  配置SnapKit可看博客 http://blog.csdn.net/q604362118/article/details/71191467
//
//  Created by huangguojian on 2017/5/5.
//  Copyright © 2017年 JY. All rights reserved.
//

import UIKit
import SnapKit

class JY_BannerView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var imgUrlArray: [String]?
    var myCollectionView: UICollectionView?
    lazy var flowLayout: UICollectionViewFlowLayout = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.headerReferenceSize = CGSize.zero
        layout.footerReferenceSize = CGSize.zero
        return layout
    }()
    

    
    init(array imgUrlArray: [String]) {
        
        super.init(frame: CGRect.zero)
        self.imgUrlArray = imgUrlArray
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        flowLayout.itemSize = self.bounds.size
    }
    
    
    
    private func initView(){

        self.initCollectionView()
        self.initTimer()
    }
    
    private func initCollectionView(){
        
        myCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: self.flowLayout)
        myCollectionView?.delegate = self
        myCollectionView?.dataSource = self
        myCollectionView?.backgroundColor = UIColor.white
        myCollectionView?.register(BannerViewCell.self, forCellWithReuseIdentifier: cellStruct.cellID)
        myCollectionView?.isPagingEnabled = true;
        myCollectionView?.showsHorizontalScrollIndicator = false
        self.addSubview(myCollectionView!)
        myCollectionView?.snp.makeConstraints({ (make) in
            make.top.bottom.left.right.equalToSuperview()
        })
        
        myCollectionView?.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { 
            self.myCollectionView?.scrollToItem(at: IndexPath(item: self.itemCount / 2, section: 0), at: .left, animated: false)
        }
        
    }
    
    private func initTimer(){
        
        _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { (Timer) in
           
            let superVC = self.findController()
            let nav = superVC?.navigationController
            if superVC == nav?.viewControllers.last{
                
                self.scrollNext()
            }
            else{
                
                self.reScorll()
            }
        }
    }
    
    private func scrollNext(){
        
        let index = Int((self.myCollectionView?.contentOffset.x)! / (self.myCollectionView?.bounds.size.width)!)
        self.myCollectionView?.scrollToItem(at: IndexPath(item: index + 1, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    /// 当bannerView所在的viewController disappear之后，让collectionView回滚到item为500左右的地方
    private func reScorll(){
        
        print("BannerView不在当前显示的VC中")
        
        let index = Int((self.myCollectionView?.contentOffset.x)! / (self.myCollectionView?.bounds.size.width)!)
        let signedNumber = (index -  self.itemCount / 2)
        let remainder = signedNumber % (self.imgUrlArray?.count)!
        
        self.myCollectionView?.scrollToItem(at: IndexPath(item: self.itemCount / 2 + remainder, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    
    //MARK: - UICollectionViewDelegateFlowLayout
    
    //MARK: - UICollectionViewDataSource
    
    let itemCount = 1000
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return itemCount
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellStruct.cellID, for: indexPath)as! BannerViewCell
        
        let index = indexPath.item % (imgUrlArray?.count)!
        cell.imgUrl = imgUrlArray?[index]
        
        return cell
    }
    
    //MARK: - UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("点击第\(indexPath.item)个")    
    }
    
    

    // MARK: - UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        print("自动滑到第\(index)个")
    }
}


/**
 *UIView扩展
 *在UIView中快速查找对应UIViewController、UINavigationController或者指定控制器的方法，原理根据事件的响应链，向上查找
 */
extension UIView {
    
    
    func findController() -> UIViewController! {
        return self.findControllerWithClass(UIViewController.self)
    }
    
    func findNavigator() -> UINavigationController! {
        return self.findControllerWithClass(UINavigationController.self)
    }
    
    func findControllerWithClass<T>(_ clzz: AnyClass) -> T? {
        var responder = self.next
        while(responder != nil) {
            if (responder!.isKind(of: clzz)) {
                return responder as? T
            }
            responder = responder?.next
        }
        
        return nil
    }
    
    
}
