//
//  PhotoCollectionViewCell.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 23/10/2023.
//

import UIKit
import SDWebImage

class PhotoCollectionViewCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionViewCell"
    
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let shortDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
        
    }()
    
   
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.addSubViews(imageView,shortDescription)
        setUpConstraints()
        
            
        
    }
    func setUpConstraints() {
        // Activate imageView constraints
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200) // Adjust the height as needed
        ])
        
        // Activate shortDescription label constraints
        NSLayoutConstraint.activate([
            shortDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8), // Set a positive value for spacing
            shortDescription.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16), // Adjust leading space as needed
            shortDescription.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16), // Adjust trailing space as needed
            shortDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8) // Adjust bottom space as needed
        ])
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    
    func configure(viewModels: photoModel) {
        imageView.sd_setImage(with: viewModels.thumbnail.asUrl)
        shortDescription.text = viewModels.shortDescription
        
       
    
    }
    
    
    
}
