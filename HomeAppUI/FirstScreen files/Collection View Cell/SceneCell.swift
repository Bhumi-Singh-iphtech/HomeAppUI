//
//  SceneCell.swift
//  HomeAppUI
//
//  Created by iPHTech 15 on 19/09/25.
//
import UIKit

class SceneCell: UICollectionViewCell {
    static let identifier = "SceneCell"
    
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
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
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
            titleLabel.centerXAnchor.constraint(equalTo: circleView.centerXAnchor)
        ])
    }
    
    func configure(with scene: (title: String, icon: String), isSelected: Bool) {
        titleLabel.text = scene.title
        iconImageView.image = UIImage(systemName: scene.icon)
        
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        iconImageView.image = nil
        circleView.backgroundColor = nil
        iconImageView.tintColor = nil
        titleLabel.textColor = nil
    }
}
