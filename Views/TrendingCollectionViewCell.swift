//
//  TrendingCollectionViewCell.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 13/10/2023.
//

import UIKit
import SDWebImage


class TrendingCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "TrendingCollectionViewCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let titleLabel: UILabel = {
        let label  = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubViews(imageView, titleLabel)
        addConstraints()
        setUpLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUpLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height: -4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.heightAnchor.constraint(equalToConstant: 10),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -3)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }
    
    public func configure(with viewModels: TrendingModel) {
        titleLabel.text = viewModels.title
        imageView.sd_setImage(with: viewModels.thumbnail.asUrl)
    
    }
    
    
}
