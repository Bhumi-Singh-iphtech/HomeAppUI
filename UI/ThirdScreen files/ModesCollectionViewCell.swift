import UIKit

class ModeCollectionViewCell: UICollectionViewCell {
    
    private let circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 35
        view.clipsToBounds = true
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(circleView)
        circleView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            circleView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            circleView.topAnchor.constraint(equalTo: contentView.topAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 70),
            circleView.heightAnchor.constraint(equalToConstant: 70),
            
            iconImageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalToConstant: 28),
            
            titleLabel.topAnchor.constraint(equalTo: circleView.bottomAnchor, constant: 6),
            titleLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor),
            titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 4),
            titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -4)
        ])
    }
    
    func configure(with mode: (title: String, icon: String), isSelected: Bool) {
        titleLabel.text = mode.title
        iconImageView.image = UIImage(systemName: mode.icon)
        
        if isSelected {
            circleView.backgroundColor = .white
            iconImageView.tintColor = .black
            titleLabel.textColor = .black
        } else {
            circleView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
            iconImageView.tintColor = .black.withAlphaComponent(0.6)
            titleLabel.textColor = .gray
        }
    }
    
    override var isSelected: Bool {
        didSet {
            UIView.animate(withDuration: 0.2) {
                if self.isSelected {
                    self.circleView.backgroundColor = .white
                    self.iconImageView.tintColor = .black
                    self.titleLabel.textColor = .black
                } else {
                    self.circleView.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
                    self.iconImageView.tintColor = .black.withAlphaComponent(0.6)
                    self.titleLabel.textColor = .gray
                }
            }
        }
    }
}
