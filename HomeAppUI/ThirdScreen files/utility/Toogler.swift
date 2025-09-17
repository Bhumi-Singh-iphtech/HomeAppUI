import UIKit

class Toogler {
    
    private var toggleBackground: UIView
    private var toggleButton: UIButton
    
    private(set) var isOn: Bool = false
    var onToggle: ((Bool) -> Void)?
    
    init(toggleBackground: UIView, toggleButton: UIButton) {
        self.toggleBackground = toggleBackground
        self.toggleButton = toggleButton
        
        setupUI()
        setupTap()
    }
    
    private func setupUI() {
        toggleBackground.layer.cornerRadius = toggleBackground.frame.height / 2
        toggleBackground.backgroundColor = .lightGray.withAlphaComponent(0.6)
        
        toggleButton.layer.cornerRadius = toggleButton.frame.height / 2
        toggleButton.backgroundColor = .white
        toggleButton.layer.shadowColor = UIColor.black.cgColor
        toggleButton.layer.shadowOpacity = 0.2
        toggleButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        toggleButton.layer.shadowRadius = 4
    }
    
    private func setupTap() {
        toggleButton.addTarget(self, action: #selector(toggleTapped), for: .touchUpInside)
    }
    
    @objc private func toggleTapped() {
        toggle()
    }
    
    func setOn(_ on: Bool, animated: Bool = true) {
        isOn = on
        updateToggle(animated: animated)
    }
    
    func toggle() {
        isOn.toggle()
        updateToggle(animated: true)
        onToggle?(isOn)
    }
    
    private func updateToggle(animated: Bool) {
        let knobSize = toggleButton.frame.width
        let padding: CGFloat = 2
        
        let newX: CGFloat
        let newColor: UIColor
        
        if isOn {
            newX = toggleBackground.frame.width - knobSize - padding
            newColor = .lightGray.withAlphaComponent(0.1)
        } else {
            newX = padding
            newColor = .lightGray.withAlphaComponent(0.6)
        }
        
        let updates = {
            self.toggleButton.frame.origin.x = newX
            self.toggleBackground.backgroundColor = newColor
        }
        
        if animated {
            UIView.animate(withDuration: 0.25, animations: updates)
        } else {
            updates()
        }
    }
}
