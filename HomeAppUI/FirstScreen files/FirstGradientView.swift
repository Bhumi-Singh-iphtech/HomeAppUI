//
//  FirstGradientView.swift
//  HomeAppUI
//
//  Created by iPHTech 15 on 18/09/25.
//

import Foundation
import UIKit
class GradientView: UIView {
    private let gradientLayer = CAGradientLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGradient()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGradient()
    }
    
    private func setupGradient() {
        gradientLayer.colors = [
            UIColor(red: 242/255, green: 212/255, blue: 176/255, alpha: 1).cgColor,
            UIColor(red: 246/255, green: 226/255, blue: 240/255, alpha: 1).cgColor,
            UIColor(red: 158/255, green: 203/255, blue: 213/255, alpha: 1).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
    }
}
