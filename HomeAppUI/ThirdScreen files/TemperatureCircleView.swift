import UIKit


class TemperatureCircleView: UIView {
    private let circleLayer = CAShapeLayer()
    private let ticksLayer = CAShapeLayer()
    private let progressLayer = CAShapeLayer()
    private let centerLabel = UILabel()
    private let celsiusLabel = UILabel()
    private let minTempLabel = UILabel()
    private let maxTempLabel = UILabel()
    private let coldCapsule = UIView()
    private let coldLabel = UILabel()
    private let coldIcon = UIImageView()
    private let plusButton = UIButton()
    private let minusButton = UIButton()
    private let innerBorderLayer = CAShapeLayer()
    private let progressDotLayer = CAShapeLayer()
    
    
    var progress: CGFloat = 0.25 {
        didSet { setNeedsLayout() }
    }
    
    var temperature: CGFloat = 22 {
        didSet {
            centerLabel.text = "\(Int(temperature))"
            // Update progress based on temperature range (15°C to 32°C)
            let range: CGFloat = maxTemperature - minTemperature
            progress = (temperature - minTemperature) / range
        }
    }
    
    
    
    var minTemperature: CGFloat = 15 {
        didSet {
            minTempLabel.text = "\(Int(minTemperature))°C"
            setNeedsLayout()
        }
    }
    
    var maxTemperature: CGFloat = 32 {
        didSet {
            maxTempLabel.text = "\(Int(maxTemperature))°C"
            setNeedsLayout()
        }
    }
    
    // Button action callbacks
    var onPlusTapped: (() -> Void)?
    var onMinusTapped: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        setupLabels()
        setupButtons()
        setupColdCapsule()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
        setupLabels()
        setupButtons()
        setupColdCapsule()
      
    }
    
    private func setupLayers() {
        backgroundColor = .clear
        layer.addSublayer(circleLayer)
        layer.addSublayer(ticksLayer)
        layer.addSublayer(innerBorderLayer)
        layer.addSublayer(progressDotLayer)
        layer.addSublayer(progressLayer)
    }
    
    private func setupLabels() {
        // Center temperature label (just the number)
        centerLabel.textAlignment = .center
        centerLabel.font = UIFont.boldSystemFont(ofSize: 50)
        centerLabel.textColor = .black
        centerLabel.text = "\(Int(temperature))"
        addSubview(centerLabel)
        
        // Celsius label below the number
        celsiusLabel.textAlignment = .center
        celsiusLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        celsiusLabel.textColor = .darkGray
        celsiusLabel.text = "°Celcius"
        addSubview(celsiusLabel)
        
        // Min temperature label
        minTempLabel.textAlignment = .center
        minTempLabel.font = UIFont.systemFont(ofSize: 14)
        minTempLabel.textColor = .darkGray;
        minTempLabel.text = "\(Int(minTemperature))°C"
        addSubview(minTempLabel)
        
        // Max temperature label
        maxTempLabel.textAlignment = .center
        maxTempLabel.font = UIFont.systemFont(ofSize: 14)
        maxTempLabel.textColor = .darkGray
        maxTempLabel.text = "\(Int(maxTemperature))°C"
        addSubview(maxTempLabel)
    }
    
    private func setupColdCapsule() {
        // Cold capsule container
        coldCapsule.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
        coldCapsule.layer.cornerRadius = 15
        coldCapsule.layer.borderWidth = 1
        coldCapsule.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        addSubview(coldCapsule)
        
        // Cold icon
        if let snowflakeImage = UIImage(systemName: "snowflake") {
            coldIcon.image = snowflakeImage.withRenderingMode(.alwaysTemplate)
            coldIcon.tintColor = .black
        }
        coldCapsule.addSubview(coldIcon)
        
        // Cold label
        coldLabel.text = "Cold"
        coldLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        coldLabel.textColor = .black
        coldCapsule.addSubview(coldLabel)
    }
    
    
    
    private func setupButtons() {
        let buttonSize: CGFloat = 40

        // Plus button
        plusButton.setTitle("+", for: .normal)
        plusButton.setTitleColor(.black, for: .normal)
        plusButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        plusButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1) // 🔹 background
        plusButton.layer.cornerRadius = buttonSize / 2
        plusButton.clipsToBounds = true
        plusButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        addSubview(plusButton)

        // Minus button
        minusButton.setTitle("-", for: .normal)
        minusButton.setTitleColor(.black, for: .normal)
        minusButton.titleLabel?.font = UIFont.systemFont(ofSize: 24)
        minusButton.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1) // 🔹 background
        minusButton.layer.cornerRadius = buttonSize / 2
        minusButton.clipsToBounds = true
        minusButton.addTarget(self, action: #selector(minusButtonTapped), for: .touchUpInside)
        addSubview(minusButton)
    }

    @objc private func plusButtonTapped() {
        onPlusTapped?()
    }
    
    @objc private func minusButtonTapped() {
        onMinusTapped?()
    }
    
    private func drawCircle() {
        let outerRect = bounds.insetBy(dx: 20, dy: 20)
        let innerRect = bounds.insetBy(dx: 30, dy: 30) // 🔹 smaller radius
      
        // outer main circle
        let circularPath = UIBezierPath(ovalIn: outerRect)
        circleLayer.path = circularPath.cgPath
        circleLayer.strokeColor = UIColor.lightGray.cgColor
        circleLayer.fillColor = UIColor.white.cgColor
        circleLayer.lineWidth = 2

        // inner grey border
        let innerPath = UIBezierPath(ovalIn: innerRect)
        innerBorderLayer.path = innerPath.cgPath
        innerBorderLayer.strokeColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        innerBorderLayer.fillColor = UIColor.clear.cgColor
        innerBorderLayer.lineWidth = 1
    }
    
    private func drawTicks() {
        let ticksPath = UIBezierPath()
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = bounds.width / 2 - 10
        let tickCount = 20
        
        // Draw only the top 2/3 of the circle (from 5π/6 to π/6)
        let startAngle: CGFloat = .pi * 5 / 6
        let endAngle: CGFloat = .pi * 1 / 6 + 2 * .pi
        
        for i in 0...tickCount {
            let angle = startAngle + (CGFloat(i) / CGFloat(tickCount)) * (endAngle - startAngle)
            let tickLength: CGFloat = 8  // 🔹 same size for all ticks

            let startPoint = CGPoint(x: center.x + cos(angle) * (radius - tickLength),
                                     y: center.y + sin(angle) * (radius - tickLength))
            let endPoint = CGPoint(x: center.x + cos(angle) * radius,
                                   y: center.y + sin(angle) * radius)
            ticksPath.move(to: startPoint)
            ticksPath.addLine(to: endPoint)
        }
        
        ticksLayer.path = ticksPath.cgPath
        ticksLayer.strokeColor = UIColor.gray.cgColor
        ticksLayer.fillColor = UIColor.clear.cgColor
        ticksLayer.lineWidth = 2
    }
    
    private func drawProgressArc() {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let outerRadius = bounds.width / 2 - 20
        let innerRadius = bounds.width / 2 - 30  // ✅ match inner border

        let startAngle: CGFloat = .pi * 5 / 6
        let endAngle: CGFloat = .pi * 1 / 6 + 2 * .pi
        let totalAngle = endAngle - startAngle

        let currentAngle = startAngle + progress * totalAngle

   // Progress arc
        let arcPath = UIBezierPath(arcCenter: center,
                                   radius: outerRadius,
                                   startAngle: startAngle,
                                   endAngle: currentAngle,
                                   clockwise: true)
        progressLayer.path = arcPath.cgPath
        progressLayer.strokeColor = UIColor.black.cgColor
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineWidth = 2
        progressLayer.lineCap = .round

        // Progress dot ON the inner border
        let dotCenter = CGPoint(
            x: center.x + cos(currentAngle) * innerRadius,
            y: center.y + sin(currentAngle) * innerRadius
        )
        let dotRadius: CGFloat = 5
        let dotPath = UIBezierPath(ovalIn: CGRect(
            x: dotCenter.x - dotRadius,
            y: dotCenter.y - dotRadius,
            width: dotRadius * 2,
            height: dotRadius * 2
        ))
        progressDotLayer.path = dotPath.cgPath
        progressDotLayer.fillColor = UIColor.gray.cgColor
    }


    override func layoutSubviews() {
        super.layoutSubviews()
        drawCircle()
        drawTicks()
        drawProgressArc()
        
        // Position center label (temperature number)
        centerLabel.frame = CGRect(x: 0, y: 0, width: 80, height: 60)
        centerLabel.center = CGPoint(x: bounds.midX, y: bounds.midY - 5)
        
        // Position Celsius label below temperature number
        celsiusLabel.frame = CGRect(x: 0, y: centerLabel.frame.maxY, width: bounds.width, height: 60)
        celsiusLabel.center.x = bounds.midX
        
        // Position min and max temperature labels
        let labelRadius = bounds.width / 2 - 5
        let minAngle: CGFloat = .pi * 5 / 6
        let maxAngle: CGFloat = .pi * 1 / 6
        
        let offset: CGFloat = 25  // 🔹 extra distance from circle

        minTempLabel.sizeToFit()
        let minX = bounds.midX + cos(minAngle) * (labelRadius + offset) - minTempLabel.bounds.width / 2
        let minY = bounds.midY + sin(minAngle) * (labelRadius + offset) - minTempLabel.bounds.height / 2
        minTempLabel.frame.origin = CGPoint(x: minX, y: minY)

        maxTempLabel.sizeToFit()
        let maxX = bounds.midX + cos(maxAngle) * (labelRadius + offset) - maxTempLabel.bounds.width / 2
        let maxY = bounds.midY + sin(maxAngle) * (labelRadius + offset) - maxTempLabel.bounds.height / 2
        maxTempLabel.frame.origin = CGPoint(x: maxX, y: maxY)
        // Position cold capsule at the top of the circle
        coldLabel.sizeToFit()
            coldIcon.frame = CGRect(x: 10, y: 7, width: 16, height: 16)
            coldLabel.frame = CGRect(x: coldIcon.frame.maxX + 5,
                                     y: 7,
                                     width: coldLabel.bounds.width,
                                     height: 20)
            
            coldCapsule.frame = CGRect(x: bounds.midX - (coldLabel.frame.maxX + 20) / 2,
                                       y: centerLabel.frame.minY - 50,  // 🔹 above the "22"
                                       width: coldLabel.frame.maxX + 10,
                                       height: 30)
        let buttonSize: CGFloat = 40

        // Y position = align vertically with centerLabel
        let buttonY = centerLabel.center.y - buttonSize / 2

        // Left (-) button → at the leftmost edge of the circle
        minusButton.frame = CGRect(
            x: bounds.minX + 40,        // padding from left edge
            y: buttonY,
            width: buttonSize,
            height: buttonSize
        )

        // Right (+) button → at the rightmost edge of the circle
        plusButton.frame = CGRect(
            x: bounds.maxX - buttonSize - 40, // padding from right edge
            y: buttonY,
            width: buttonSize,
            height: buttonSize
        )

        
        
        
        
    }
}
