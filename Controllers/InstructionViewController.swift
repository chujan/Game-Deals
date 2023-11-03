//
//  InstructionViewController.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 22/10/2023.
//

import UIKit
import SafariServices

class InstructionViewController: UIViewController {
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .medium)
        spinner.tintColor = .red
        //spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
            
        
    }()
    
    private let containerView: UIView = {
           let view = UIView()
           view.translatesAutoresizingMaskIntoConstraints = false
           return view
       }()

    
    
    private var giveaway: [Giveaway] = []
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        
        
        return table
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(containerView)
        containerView.addSubview(spinner)
        containerView.addSubview(tableView)
        addShareButton()
        spinner.startAnimating()
        fetchData()
        tableView.dataSource = self
        tableView.delegate = self
        title = "Instructions"
      
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
      
       
     
       
       
        tableView.register(InstructionsTableViewCell.self, forCellReuseIdentifier: InstructionsTableViewCell.identifier)
        
        NSLayoutConstraint.activate([
                    containerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                    containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
                    containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
                    containerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
                ])

                // Add constraints for spinner and tableView within containerView
                NSLayoutConstraint.activate([
                    spinner.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
                    spinner.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
                    tableView.topAnchor.constraint(equalTo: containerView.topAnchor),
                    tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
                ])
       
        
    }
    
    private func fetchData() {
        //spinner.startAnimating()
        APICaller.shared.getTrending { [weak self] result in
            switch result {
            case.success(let model):
                DispatchQueue.main.async {
                    self?.giveaway = model
                    self?.tableView.reloadData()
                   // self?.spinner.stopAnimating()
                }
            case.failure(let error):
                print(error.localizedDescription)
            
            }
        }
        
        
    }
    
    private  func addShareButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(didTapSearch))
    }
    
    @objc private func didTapSearch() {
        let vc = SearchViewController()
      
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
}
    
extension InstructionViewController: UITableViewDelegate, UITableViewDataSource{
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let giveawayURL = giveaway[indexPath.row].openGiveawayURL
        
        if let url = URL(string: giveawayURL) {
            let safariViewController = SFSafariViewController(url: url)
            safariViewController.modalPresentationStyle = .popover
            present(safariViewController, animated: true, completion: nil)
        } else {
            print("Invalid URL")
        }
        
        
        
    }
}


    

    

