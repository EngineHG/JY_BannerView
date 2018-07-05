//
//  ViewController.swift
//  JY_BannerViewDemo
//
//  Created by huangguojian on 2017/5/5.
//  Copyright © 2017年 JY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var bannerView: JY_BannerView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initView()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func initView(){
        
        self.automaticallyAdjustsScrollViewInsets = false//处理scrollview及其子类顶部空白问题
        
        bannerView = JY_BannerView(array: ["1","2","3","4","5"])
        self.view.addSubview(bannerView!)
        bannerView?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(64)
            make.left.right.equalToSuperview()
            make.height.equalTo(150)
        }
        
        let pushBtn: UIButton = {
            let btn = UIButton()
            btn.setTitle("下个controller", for: .normal)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.addTarget(self, action:#selector(push2NextVC), for: .touchUpInside)
            return btn
        }()
        self.view.addSubview(pushBtn)
        pushBtn.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
        }
    }

    @objc func push2NextVC(){
        let nextVC = BVC()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}

