//
//  FloatTabBar.swift
//  Floating-TabBar
//
//  Created by user195713 on 7/14/21.
//

import UIKit

class FloatTabBar: UITabBar {
    override func layoutSubviews() {
           super.layoutSubviews()

           // iOS 11: puts the titles to the right of image for horizontal size class regular. Only want offset when compact.
           // iOS 9 & 10: always puts titles under the image. Always want offset.
           var verticalOffset: CGFloat = 6.0

           if #available(iOS 11.0, *), traitCollection.horizontalSizeClass == .regular {
               verticalOffset = 0.0
           }

           let imageInset = UIEdgeInsets(
               top: verticalOffset,
               left: 0.0,
               bottom: -verticalOffset,
               right: 0.0
           )

           for tabBarItem in items ?? [] {
               tabBarItem.title = ""
               tabBarItem.imageInsets = imageInset
           }
       }
}
