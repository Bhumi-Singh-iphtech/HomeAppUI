import UIKit

class TabCell: UICollectionViewCell {
    static let identifier = "TabCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        contentView.layer.cornerRadius = 20
        contentView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func configure(with text: String, isSelected: Bool) {
        label.text = text
        
        if isSelected {
            contentView.backgroundColor = UIColor.white.withAlphaComponent(0.9)
            label.textColor = .black
        } else {
            contentView.backgroundColor = UIColor.white.withAlphaComponent(0.2)
            label.textColor = .darkGray
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        label.text = nil
        contentView.backgroundColor = nil
        label.textColor = nil
    }
}
