import UIKit

class DeviceCollectionCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    @IBOutlet weak var iconBackground: UIView!
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var toggleBackground: UIView!
    @IBOutlet weak var toggleButton: UIButton!
    
    // MARK: - Properties
    private var isOn = false
    var toggleAction: (() -> Void)?
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Transparent background
        backgroundColor = .clear
        contentView.backgroundColor = .white
        
        // Labels
        titleLabel.font = UIFont.boldSystemFont(ofSize:25)
        titleLabel.textColor = .black
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textColor = .gray
        
        // Status button
        statusButton.layer.cornerRadius = 12
        statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        statusButton.setTitleColor(.black, for: .normal)
        statusButton.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        // Toggle background
        toggleBackground.layer.cornerRadius = toggleBackground.frame.height / 2
        toggleBackground.backgroundColor = .lightGray
        
        // Toggle knob
        toggleButton.layer.cornerRadius = toggleButton.frame.height / 2
        toggleButton.backgroundColor = .white
        toggleButton.layer.shadowColor = UIColor.black.cgColor
        toggleButton.layer.shadowOpacity = 0.2
        toggleButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        toggleButton.layer.shadowRadius = 4
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Rounded card look
        contentView.layer.cornerRadius = 30
        contentView.layer.masksToBounds = false
        
        // Shadow for floating effect
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.05
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 8
        layer.masksToBounds = false
        layer.cornerRadius = 20
    }
    
    // MARK: - Configure Cell
    func configure(with device: Device) {
        iconView.image = UIImage(named: device.icon)
        titleLabel.text = device.name
        subtitleLabel.text = device.subtitle
        statusButton.setTitle(device.status, for: .normal)
        
        isOn = device.isOn
        updateToggle(animated: false)
        
        // reset selection UI when reused
        updateSelectionState()
    }
    
    // MARK: - Toggle Update
    private func updateToggle(animated: Bool = true) {
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
    
    // MARK: - Selection State
    override var isSelected: Bool {
        didSet {
            updateSelectionState()
        }
    }
    
    private func updateSelectionState() {
        if isSelected {
            self.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        } else {
            self.contentView.backgroundColor = UIColor.white.withAlphaComponent(0.6)

        }
        self.contentView.layer.cornerRadius = 20
        self.contentView.layer.masksToBounds = true
    }
    
    // MARK: - Actions
    @IBAction func toggleTapped(_ sender: UIButton) {
        isOn.toggle()
        updateToggle()
        toggleAction?()
    }
}
