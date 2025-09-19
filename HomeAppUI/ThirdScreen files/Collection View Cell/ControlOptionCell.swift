import UIKit

class ControlOptionCell: UICollectionViewCell {
    static let identifier = "ControlOptionCell"
    
    @IBOutlet weak var iconButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
        
        iconButton.tintColor = .black
        iconButton.isUserInteractionEnabled = false
        iconButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
        iconButton.layer.cornerRadius = 20
        iconButton.clipsToBounds = true
        
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .left
    }
    
    func configure(with option: (title: String, icon: String)) {
        iconButton.setImage(UIImage(systemName: option.icon), for: .normal)
        titleLabel.text = option.title
    }
}
