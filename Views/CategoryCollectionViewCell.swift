//
//  CategoryCollectionViewCell.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 21/10/2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "CategoryCollectionViewCell"
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private let platformlabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .right
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
        
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubViews(titleLabel, valueLabel, platformlabel)
        addContraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addContraint() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            platformlabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 10),
            platformlabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            platformlabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            platformlabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
                ])
           
           
            
        
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
        platformlabel.text = nil
        contentView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func configure(with viewModel: CategoryModel, borderColor: UIColor) {
        titleLabel.text = "Genre: \(viewModel.genre)"
        valueLabel.text = "Release on: \(viewModel.releaseDate)"
        platformlabel.text = "Platform: \(viewModel.platform)"
        contentView.layer.borderColor = borderColor.cgColor
    }
}
