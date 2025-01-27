//
//  UserDetailViewController'ı.swift
//  UserListApp
//
//  Created by Musa Adıtepe on 27.01.2025.
//

import UIKit

class UserDetailViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    /*
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var companyLabel: UILabel!
    */
    private var viewModel: UserDetailViewModel!
    
    static func instantiate(with user: User) -> UserDetailViewController {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let controller = storyboard.instantiateViewController(withIdentifier: "UserDetailViewController") as? UserDetailViewController else {
                fatalError("UserDetailViewController could not be instantiated from storyboard")
            }
            controller.viewModel = UserDetailViewModel(user: user)
            return controller
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            styleLabels()
        }
        
        private func setupUI() {
            title = viewModel.name
            nameLabel.text = "İsim: \(viewModel.name)"
            emailLabel.text = "E-posta: \(viewModel.email)"
            phoneLabel.text = "Telefon: \(viewModel.phone)"
            websiteLabel.text = "Website: \(viewModel.website)"
            addressLabel.text = "Adres: \(viewModel.address)"
            companyLabel.text = "Şirket: \(viewModel.company)"
        }
        
        private func styleLabels() {
            let labels = [nameLabel, emailLabel, phoneLabel, websiteLabel, addressLabel, companyLabel]
            
            labels.forEach { label in
                label?.numberOfLines = 0
                label?.font = .systemFont(ofSize: 16)
                
                if let text = label?.text, let colonIndex = text.firstIndex(of: ":") {
                    let attributedText = NSMutableAttributedString(string: text)
                    attributedText.addAttribute(.font,
                                              value: UIFont.systemFont(ofSize: 16, weight: .bold),
                                              range: NSRange(location: 0, length: text.distance(from: text.startIndex, to: colonIndex)))
                    label?.attributedText = attributedText
                }
            }
            
            view.backgroundColor = .systemBackground
        }
    }
