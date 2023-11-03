//
//  platformCollectionViewCell.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 29/10/2023.
//

import UIKit

class platformCollectionViewCell: UICollectionViewCell {
    static let identifier = "platformCollectionViewCell"
    private let valueLabel: UILabel = {
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
        contentView.addSubview(valueLabel)
        addContraint()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addContraint() {
        NSLayoutConstraint.activate([
           valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
           valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
          valueLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -10),
           ])
            
            }
    
    func configure(viewModel: PlatformModel) {
        valueLabel.text = "platform: \(viewModel.platform)"
       
    }
    
}
