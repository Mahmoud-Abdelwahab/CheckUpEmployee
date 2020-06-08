//
//  UIVIewGradient.swift
//  CheckUpEmployee
//
//  Created by Hassan Khamis on 6/5/20.
//  Copyright © 2020 Mahmoud.kasper. All rights reserved.
//

import Foundation
import UIKit
extension UIView{
    func addGradientBackground(firstColor: UIColor, secondColor: UIColor){
        clipsToBounds = true
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [firstColor.cgColor, secondColor.cgColor]
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        print(gradientLayer.frame)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}
