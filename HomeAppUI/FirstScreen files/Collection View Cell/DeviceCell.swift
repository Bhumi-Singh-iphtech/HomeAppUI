import UIKit

class DeviceCell: UICollectionViewCell {
    static let identifier = "DeviceCell"
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    @IBOutlet weak var toggleBackground: UIView!
    @IBOutlet weak var toggleButton: UIButton!
    
    private var toggler: Toogler!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 40
        contentView.clipsToBounds = true
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textColor = .gray
        
        statusButton.layer.cornerRadius = 12
        statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        statusButton.setTitleColor(.black, for: .normal)
        statusButton.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        // Setup the toggler
        toggler = Toogler(toggleBackground: toggleBackground, toggleButton: toggleButton)
        toggler.onToggle = { isOn in
            print("Cell toggle state:", isOn)
        }
        
        // Enable user interaction for both views
        toggleButton.isUserInteractionEnabled = true
        toggleBackground.isUserInteractionEnabled = true
        
        // Add tap gesture to toggle button only
        let buttonTap = UITapGestureRecognizer(target: self, action: #selector(toggleButtonTapped))
        toggleButton.addGestureRecognizer(buttonTap)
        
        let backgroundTap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        toggleBackground.addGestureRecognizer(backgroundTap)
    }
    
    @objc private func toggleButtonTapped() {
        toggler.toggle()
    }
    
    @objc private func backgroundTapped() {
        print("Toggle background tapped - preventing navigation")
    }
    
    func configure(with device: Device) {
        // Safe way to load system images with fallback
        if let systemImage = UIImage(systemName: device.icon) {
            iconView.image = systemImage
        } else {
            // Fallback to a default image if the system icon isn't found
            iconView.image = UIImage(systemName: "questionmark.circle")
            print("Warning: System image '\(device.icon)' not found")
        }
        
        titleLabel.text = device.name
        subtitleLabel.text = device.subtitle
        statusButton.setTitle(device.status, for: .normal)
        toggler.setOn(device.isOn, animated: false)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        iconView.image = nil
        titleLabel.text = nil
        subtitleLabel.text = nil
        statusButton.setTitle(nil, for: .normal)
    }
}
