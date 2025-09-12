import UIKit

class DeviceCell: UICollectionViewCell {
    static let identifier = "DeviceCell"
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var statusButton: UIButton!
    
    // 🔹 Toggle parts
    @IBOutlet weak var toggleBackground: UIView!
    @IBOutlet weak var toggleButton: UIButton!
    
    private var toggler: Toogler!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Cell style
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 40
        contentView.clipsToBounds = true
        
        // Labels
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.textColor = .black
        subtitleLabel.font = UIFont.systemFont(ofSize: 12)
        subtitleLabel.textColor = .gray
        
        // Status button
        statusButton.layer.cornerRadius = 12
        statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        statusButton.setTitleColor(.black, for: .normal)
        statusButton.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        
        
        
        
        toggler = Toogler(toggleBackground: toggleBackground, toggleButton: toggleButton)
        toggler.onToggle = { isOn in
            print("Cell toggle state:", isOn)
        }
    }
    
    func configure(with device: Device) {
        iconView.image = UIImage(systemName: device.icon)
        titleLabel.text = device.name
        subtitleLabel.text = device.subtitle
        statusButton.setTitle(device.status, for: .normal)
        
        toggler.setOn(device.isOn, animated: false)
    }
    
    @IBAction func toggleTapped(_ sender: UIButton) {
        toggler.toggle()
    }
}
