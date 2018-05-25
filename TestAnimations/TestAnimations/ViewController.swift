//
//  ViewController.swift
//  TestAnimations
//
//  Created by MacPro on 2018/5/14.
//  Copyright © 2018年 Centaline. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加使用的视图
        view.backgroundColor = UIColor.gray
        
        // 设置运动的view
        let view1 = UIView(frame: CGRect(x:10, y:200, width:100, height: 100))
        
        view1.backgroundColor = UIColor.red
        view.addSubview(view1)
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(view1Clicked(tap:)))
        view1.addGestureRecognizer(tap)
    }
    
    
    
    
    /// 点击了移动的是视图
    @objc func view1Clicked(tap: UITapGestureRecognizer) {
        NSLog("UIView Clicked ")
        
        let theView = tap.view!
    
        // begin commit duration
        // 开始动画配置
        UIView.beginAnimations("viewAnimationmyrea", context: nil)
        // 设置运行时间
        UIView.setAnimationDuration(0.2)
       // 设置运动开始和结束的委托
        UIView.setAnimationDelegate(self)
        // 设置缓动方式
        UIView.setAnimationCurve(.easeIn)
        // 位置运动, 改变可动属性
        theView.frame = CGRect(x: theView.frame.origin.x, y: theView.frame.origin.y, width:theView.frame.size.width, height: theView.frame.size.height)
        // 颜色渐变
        theView.backgroundColor = UIColor.green

        // 透明度渐变
        theView.alpha = 0.5
        // 开始动画(commit)
        UIView.commitAnimations()
        
    }
}

