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
    private var toggler: Toogler!
    var toggleAction: (() -> Void)?
    private var buttonTap: UITapGestureRecognizer!
    private var backgroundTap: UITapGestureRecognizer!
    
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
        
        // Initialize the toggler
        toggler = Toogler(toggleBackground: toggleBackground, toggleButton: toggleButton)
        toggler.onToggle = { [weak self] isOn in
            self?.toggleAction?()
        }
        
        // Enable user interaction for both views
        toggleButton.isUserInteractionEnabled = true
        toggleBackground.isUserInteractionEnabled = true
        
        // Add tap gesture to toggle button only
        buttonTap = UITapGestureRecognizer(target: self, action: #selector(toggleButtonTapped))
        toggleButton.addGestureRecognizer(buttonTap)
        
        // Add tap gesture to background to prevent navigation but not trigger toggle
        backgroundTap = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        toggleBackground.addGestureRecognizer(backgroundTap)
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
        toggler.setOn(device.isOn, animated: false)
        
        // reset selection UI when reused
        updateSelectionState()
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
    
    // MARK: - Toggle Actions
    @objc private func toggleButtonTapped() {
        toggler.toggle()
    }
    
    @objc private func backgroundTapped() {
        // Do nothing - just prevent the cell selection
        print("Toggle background tapped - preventing navigation")
    }
    
    // MARK: - Hit Test to prevent cell selection when toggle areas are tapped
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Convert point to toggleButton's coordinate system
        let toggleButtonPoint = convert(point, to: toggleButton)
        
        // Check if the point is inside the toggle button
        if toggleButton.bounds.contains(toggleButtonPoint) {
            return toggleButton
        }
        
        // Convert point to toggleBackground's coordinate system
        let toggleBackgroundPoint = convert(point, to: toggleBackground)
        
        // Check if the point is inside the toggle background
        if toggleBackground.bounds.contains(toggleBackgroundPoint) {
            return toggleBackground
        }
        
        // For all other areas, let the superclass handle it
        return super.hitTest(point, with: event)
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
       
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.6)
    }
}
