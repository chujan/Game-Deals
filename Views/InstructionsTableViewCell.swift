//
//  InstructionsTableViewCell.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 22/10/2023.
//

import UIKit

class InstructionsTableViewCell: UITableViewCell {
    static let identifier = "InstructionsTableViewCell"
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .medium)
        label.numberOfLines = 0
        label.setCharacterSpacing(15)
        
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
        
    }()
    
    private let valueLabel : UILabel = {
        let label = UILabel()
        label.text = "type"
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.textColor = .secondaryLabel
        return label
        
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubViews(instructionLabel,typeLabel, valueLabel)
        addConstraint()
        accessoryType = .disclosureIndicator
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        instructionLabel.text = nil
        typeLabel.text = nil
    }
    
    private func addConstraint() {
        NSLayoutConstraint.activate([
            instructionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            instructionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            instructionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLabel.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 10),
            valueLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            typeLabel.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 10),
            typeLabel.leftAnchor.constraint(equalTo: valueLabel.leftAnchor, constant: 300),
            typeLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10),
            
        ])
    }
    
    
    public func configure(with viewModel: InstructionModel) {
        instructionLabel.text = viewModel.instructions
        typeLabel.text = viewModel.type
    }

    

}
