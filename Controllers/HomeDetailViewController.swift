import UIKit
import SDWebImage

class HomeDetailViewController: UIViewController {
    private var giveaway: Giveaway
     
    
    init(giveaway: Giveaway) {
        self.giveaway = giveaway
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isScrollEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
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
    
//    private let desLabel: UILabel = {
//        let label = UILabel()
//        label.
//        label.translatesAutoresizingMaskIntoConstraints = false
//        label.font = .systemFont(ofSize: 18, weight: .medium)
//        label.textAlignment = .center
//        return label
//    }()
    
    private let instructionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    
    private let valueLabel : UILabel = {
        let label = UILabel()
        label.text = "description"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemBrown
        return label
        
    }()
    private let priceLabel : UILabel = {
        let label = UILabel()
        label.text = "worth"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemBrown
        return label
        
    }()
    private let instructLabel : UILabel = {
        let label = UILabel()
        label.text = "instruction"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .systemBrown
        return label
        
    }()
    private let tyLabel : UILabel = {
        let label = UILabel()
        label.text = "type"
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = .systemBrown
        return label
        
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Play", for: .normal)
        button.backgroundColor = .systemBrown
        let boldFold = UIFont.boldSystemFont(ofSize: 18)
        button.layer.cornerRadius = 8
        button.titleLabel?.shadowOffset = CGSize(width: 2, height: 2) 
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return button
        
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = giveaway.title
        contentView.addSubview(imageView)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(worthLabel)
        contentView.addSubview(instructionLabel)
        contentView.addSubview(statusLabel)
        contentView.addSubViews(valueLabel)
        contentView.addSubViews(priceLabel)
        contentView.addSubViews(instructLabel)
        contentView.addSubViews(tyLabel)
        contentView.addSubview(nextButton)
       

        scrollView.addSubview(contentView)
        view.addSubview(scrollView)

        print("ScrollView contentSize: \(scrollView.contentSize)")
       

        
        setUpConstraints()
        
        if let thumbnailURL = URL(string: giveaway.thumbnail) {
            imageView.sd_setImage(with: thumbnailURL, completed: nil)
        } else {
            imageView.image = UIImage(named: "placeholderImage")
        }
        
        descriptionLabel.text = giveaway.description ?? "No description available"
        descriptionLabel.sizeToFit()
        worthLabel.text = giveaway.worth ?? "N/A"
        worthLabel.sizeToFit()
        instructionLabel.text = giveaway.instructions ?? "No"
        instructionLabel.sizeToFit()
        statusLabel.text = giveaway.type ?? "No"
        statusLabel.sizeToFit()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let totalHeight = imageView.intrinsicContentSize.height +
                             descriptionLabel.intrinsicContentSize.height +
                             worthLabel.intrinsicContentSize.height +
                             instructionLabel.intrinsicContentSize.height +
                             statusLabel.intrinsicContentSize.height +
                             240  // Add a buffer space

            scrollView.contentSize = CGSize(width: view.bounds.width, height: totalHeight)
        print("View did layout subviews")
        
    }

    
   
   
    
    private func setUpConstraints() {
            

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            valueLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            descriptionLabel.topAnchor.constraint(equalTo: valueLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
          priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            worthLabel.topAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 20),
            worthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            worthLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            instructLabel.topAnchor.constraint(equalTo: worthLabel.bottomAnchor, constant: 20),
            instructLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            instructLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            instructionLabel.topAnchor.constraint(equalTo: instructLabel.bottomAnchor, constant: 20),
            instructionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            instructionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
           tyLabel.topAnchor.constraint(equalTo: instructionLabel.bottomAnchor, constant: 10),
            tyLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            tyLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            
            statusLabel.topAnchor.constraint(equalTo: tyLabel.bottomAnchor, constant: -10),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            nextButton.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10),
                    nextButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
                    nextButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: +20)
        ])
        let totalHeight = imageView.intrinsicContentSize.height +
        descriptionLabel.intrinsicContentSize.height +
        worthLabel.intrinsicContentSize.height +
        instructionLabel.intrinsicContentSize.height +
        statusLabel.intrinsicContentSize.height +
        240  // Add a buffer space
        
        scrollView.contentSize = CGSize(width: view.bounds.width, height: totalHeight)
        
    }
    @objc private func playButtonTapped() {
        
        guard !giveaway.openGiveawayURL.isEmpty,
                  let gameUrl = URL(string: giveaway.openGiveawayURL) else {
                // Handle the case where the game URL is not available or not a valid URL
                return
            }


        if UIApplication.shared.canOpenURL(gameUrl) {
            // Open the URL using Safari services
            UIApplication.shared.open(gameUrl, options: [:], completionHandler: { success in
                if !success {
                    // Handle the case where the URL cannot be opened
                    print("Failed to open URL")
                }
            })
        } else {
            // Handle the case where the URL cannot be opened
            print("Cannot open URL")
        }
    }

    
    
}

