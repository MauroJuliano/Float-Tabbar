//
//  Floating-TabBar.swift
//  Floating-TabBar
//
//  Created by user195713 on 7/14/21.
//

import UIKit

class FloatingTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let myTabBar = FloatTabBar()
        
        let layer = CAShapeLayer()
        layer.path = UIBezierPath(roundedRect: CGRect(x: 30, y: tabBar.bounds.minY + 5, width: tabBar.bounds.width - 60, height: tabBar.bounds.height + 5), cornerRadius: (tabBar.frame.width/2)).cgPath
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        layer.shadowRadius = 25.0
        layer.shadowOpacity = 0.3
        layer.borderWidth = 1.0
        layer.opacity = 1.0
        layer.isHidden = false
        layer.masksToBounds = false
        layer.fillColor = UIColor.white.cgColor
    
        myTabBar.layer.insertSublayer(layer, at: 0)
        
        if let items = myTabBar.items {
            print(tabBar.items?.count)
            items.forEach { item in item.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0) }
        }

        myTabBar.itemWidth = 40.0
        myTabBar.itemPositioning = .centered
        //tabBarItem.image?.withRenderingMode(.automatic)
        myTabBar.backgroundImage = getColoredImage(color: .clear, size: CGSize(width: view.frame.width, height: 100))
        
        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        self.setValue(myTabBar, forKey: "tabBar")
    }
    
    func getColoredImage(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image:UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage()}
        UIGraphicsEndImageContext()
        return image
    }
}
//extension UITabBarItem {
//    func tabBarItemShowingOnlyImage() -> UITabBarItem {
//        // offset to center
//        self.imageInsets = UIEdgeInsets(top:10,left:0,bottom:-15,right:0)
//        // displace to hide
//       // self.titlePositionAdjustment(UIOffset(horizontal: 0, vertical: 0))
//        return self
//    }
//}

