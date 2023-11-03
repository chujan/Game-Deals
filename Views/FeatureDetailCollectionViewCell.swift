//
//  FeatureDetailCollectionViewCell.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 28/10/2023.
//

import UIKit

class FeatureDetailCollectionViewCell: UICollectionViewCell {
    static let identifier = "FeatureDetailCollectionViewCell"
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
//    private let valueLabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 18, weight: .medium)
//        label.textAlignment = .right
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//
//    }()
//    private let platformlabel: UILabel = {
//        let label = UILabel()
//        label.font = .systemFont(ofSize: 18, weight: .medium)
//        label.textAlignment = .right
//        label.numberOfLines = 0
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//
//    }()
//
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(titleLabel)
        addContraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addContraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10)
            
           
           
            
            
        ])
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
       
        contentView.layer.borderColor = UIColor.clear.cgColor
    }
    
    
    
    func configure(with viewModel: FeaturedDetailModel, borderColor: UIColor) {
        titleLabel.text = "Genre: \(viewModel.genre)"
        
        contentView.layer.borderColor = borderColor.cgColor
            
    }
    
}
