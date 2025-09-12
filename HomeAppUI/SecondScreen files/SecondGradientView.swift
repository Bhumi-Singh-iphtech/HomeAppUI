import UIKit

class SecondGradientView: UIView {
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
            UIColor(hex: "F7E68B").cgColor,  // pale yellowish top leading
            UIColor(hex: "#F2D4B0").cgColor,  // pastel peach/pale yellow
            UIColor(hex: "#9ECBD5").cgColor   // teal bottom
        ]
        
        // Smoothly blend from top-left → bottom
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)   // top-left
        gradientLayer.endPoint   = CGPoint(x: 0.5, y: 1.0)   // bottom center
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = bounds
        
        
    }
}

// MARK: - UIColor Hex Extension
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: r, green: g, blue: b, alpha: 1.0)
    }
}
