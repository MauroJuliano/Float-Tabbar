//
//  MyTabBarItem.swift
//  Floating-TabBar
//
//  Created by user195713 on 7/14/21.
//

import UIKit

@IBDesignable
class MyTabBarItem: UITabBarItem {
    override func awakeFromNib() {
         super.awakeFromNib()
        setup()
     }
     func setup() {
         if let image = image {
         }
         if let image = selectedImage {
             selectedImage = image.withRenderingMode(.alwaysOriginal)
         }
     }}
