//
//  CustomTabBarController.swift
//  Custom-Tabbar
//
//  Created by Mauro Figueiredo on 07/07/21.
//  Copyright © 2021 Mauro Figueiredo. All rights reserved.
//

import UIKit

open class CustomTabBarController: UITabBarController {
    fileprivate var shouldSelectOnTabBar = true
    
    open override var selectedViewController: UIViewController? {
        willSet {
            guard shouldSelectOnTabBar,
                let newValue = newValue else {
                    shouldSelectOnTabBar = true
                    return
            }
            guard let tabBar = tabBar as? CustomTabBar, let index = viewControllers?.index(of: newValue) else {
                return
            }
            tabBar.select(itemAt: index, animated: false)
        }
        }
    open override var selectedIndex: Int {
        willSet{
            guard shouldSelectOnTabBar else {
                shouldSelectOnTabBar = true
                return
            }
            guard let tabBar = tabBar as? CustomTabBar else {
                return
            }
            tabBar.select(itemAt: selectedIndex, animated: false)
        }
    }
    open override func viewDidLoad(){
        super.viewDidLoad()
        let tabBar = CustomTabBar()
        tabBar.layer.masksToBounds = true
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: tabBar.bounds.minY + 5, width: tabBar.bounds.width - 60, height: tabBar.bounds.height + 10), cornerRadius: (tabBar.frame.width/2)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
        
        tabBar.layer.insertSublayer(layer, at: 0)
        
        if let items = tabBar.items {
            items.forEach { item in
                item.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -15, right: 0)
            }
        }
        
        tabBar.itemWidth = 30.0
        tabBar.itemPositioning = .centered
                                  
        //tabBar.layer.cornerRadius = 40
        //tabBar.layer.maskedCorners = [.layerMaxXMaxYCorner,
//                                      .layerMaxXMinYCorner,
//                                      .layerMinXMaxYCorner,
//                                      .layerMinXMinYCorner]
        self.setValue(tabBar, forKey: "tabBar")
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    private var _barHeight: CGFloat = 74
    open var barHeight: CGFloat {
        get {
            if #available(iOS 11.0, *) {
                return _barHeight + view.safeAreaInsets.bottom
            }else {
                return _barHeight
            }
     }
        set {
            _barHeight = newValue
            updateTabBarFrame()
        }
    }
    
    private func updateTabBarFrame(){
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = barHeight
        tabFrame.origin.y = self.view.frame.size.height - barHeight
        self.tabBar.frame = tabFrame
        tabBar.setNeedsLayout()
    }
    
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTabBarFrame()
    }
    
    open override func viewSafeAreaInsetsDidChange() {
        if #available(iOS 11.0, *) {
            super.viewSafeAreaInsetsDidChange()
        }
        updateTabBarFrame()
    }
    open override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let idx = tabBar.items?.index(of: item) else {
            return
        }
        if let controller = viewControllers?[idx] {
            shouldSelectOnTabBar = false
            selectedIndex = idx
            delegate?.tabBarController?(self, didSelect: controller)
        }
    }
}
