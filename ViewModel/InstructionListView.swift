//
//  InstructionListView.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 22/10/2023.
//

import UIKit

class InstructionListView: UIView {
    private var giveaway: [Giveaway] = []
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
    
        
        return table
        
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        tableView.register(InstructionsTableViewCell.self, forCellReuseIdentifier: InstructionsTableViewCell.identifier)
        addSubview(tableView)
        translatesAutoresizingMaskIntoConstraints = false
        configureTable()
        addConstraints()
        
        APICaller.shared.getTrending { [weak self] result in
            switch result {
            case.success(let model):
                DispatchQueue.main.async {
                    self?.giveaway = model
                    self?.tableView.reloadData()
                }
            case.failure(let error):
                print(error.localizedDescription)
            
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTable() {
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    private func addConstraints() {
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: centerYAnchor),
            tableView.widthAnchor.constraint(equalTo: widthAnchor, constant: -20), // Optional: Set a specific width if needed
            tableView.heightAnchor.constraint(equalTo: heightAnchor, constant: -20) // Optional: Set a specific height if needed
        ])
    }

    
    
}


extension InstructionListView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return giveaway.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InstructionsTableViewCell.identifier, for: indexPath) as? InstructionsTableViewCell else  {
            return UITableViewCell()
        }
        let viewModel = giveaway[indexPath.row]
        cell.configure(with: InstructionModel(instructions: viewModel.instructions, type: viewModel.type))
        return cell
        
        
    }
    
    
}
