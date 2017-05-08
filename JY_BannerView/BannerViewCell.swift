//
//  BannerViewCell.swift
//  JY_BannerViewDemo
//
//  Created by huangguojian on 2017/5/8.
//  Copyright © 2017年 JY. All rights reserved.
//

import UIKit

class BannerViewCell: UICollectionViewCell {
    
    let bannerImgView = UIImageView()
    var imgUrl: String?{
        
        didSet{
            
            self.updateView()
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        self.initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initView(){
        self.contentView.backgroundColor = UIColor.white
        self.contentView.addSubview(bannerImgView)
        bannerImgView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    private func updateView(){
        
        bannerImgView.image = UIImage.init(named: self.imgUrl!)
    }
}

struct cellStruct {
    static let cellID:String = "JY_BannerViewCellID"
}
