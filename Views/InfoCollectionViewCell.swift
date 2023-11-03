//
//  InfoCollectionViewCell.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 23/10/2023.
//

import UIKit

class InfoCollectionViewCell: UICollectionViewCell {
    static let identifer = "InfoCollectionViewCell"
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        return label
        
    }()
    
    private let worthLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        return label
        
    }()
    
   
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpConstraints()
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 0
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    
    func setUpConstraints() {
        // Add subviews to contentView before setting up constraints
        contentView.addSubViews(descriptionLabel, worthLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -100),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -3),
            descriptionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            
            
            
            worthLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: -300),
            worthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            worthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            worthLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }


        
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        descriptionLabel.text = nil
        worthLabel.text = nil
        
    }
    
    public func configure(Models: InfoModel ) {
        //print("configure cell:\(viewModel)")
        descriptionLabel.text = Models.description
        worthLabel.text = Models.worth
    }
//    
//    func configureEmptyState() {
//        descriptionLabel.text = "no description"
//        worthLabel.text = "N/A"
//    }
//    
}
