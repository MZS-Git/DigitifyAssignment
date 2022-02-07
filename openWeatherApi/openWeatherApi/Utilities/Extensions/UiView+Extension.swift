//
//  UiView+Extension.swift
//  SolidTest
//
//  Created by Muhammad Zain Shahid on 07/02/2022.
//

import Foundation
import UIKit

extension UIView {
    
    func addGradient() {
        let gradientLayer : CAGradientLayer = CAGradientLayer()
        gradientLayer.frame.size = self.frame.size
        let color3 = UIColor(red:3.0/255, green:8.0/255, blue:34.0/255, alpha:1.0).cgColor
        let color2 = UIColor(red:32.0/255, green:36.0/255, blue: 56.0/255, alpha:1.0).cgColor
        let color1 = UIColor(red:43.0/255, green:50.0/255, blue: 74.0/255, alpha:1.0).cgColor
        let color0 = UIColor(red:49.0/255, green:59.0/255, blue: 87.0/255, alpha:1.0).cgColor
        gradientLayer.locations = [0.0, 0.2, 0.6, 1.0]
        gradientLayer.colors = [color0, color1, color2, color3]
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
