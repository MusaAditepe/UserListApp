//
//  UserListViewController.swift
//  UserListApp
//
//  Created by Musa Adıtepe on 27.01.2025.
//

import UIKit

class UserListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = UserListViewModel()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setupUI()
            setupViewModel()
            viewModel.fetchUsers()
        }
        
    private func setupUI() {
          title = "Kullanıcılar"
          navigationController?.navigationBar.prefersLargeTitles = true
          tableView.register(UserTableViewCell.self, forCellReuseIdentifier: UserTableViewCell.identifier)
          tableView.delegate = self
          tableView.dataSource = self
          tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
          tableView.rowHeight = UITableView.automaticDimension
          tableView.estimatedRowHeight = 80
      }
      
      private func setupViewModel() {
          viewModel.delegate = self
      }
  }

    extension UserListViewController: UITableViewDelegate, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return viewModel.numberOfUsers()
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as? UserTableViewCell else {
                return UITableViewCell()
            }
            
            let user = viewModel.getUserAt(indexPath.row)
            cell.configure(with: user)
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("Hücreye tıklandı: \(indexPath.row)")
            tableView.deselectRow(at: indexPath, animated: true)
            let user = viewModel.getUserAt(indexPath.row)
            let detailVC = UserDetailViewController.instantiate(with: user)
            print("DetailVC oluşturuldu")  // Debug için
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

    extension UserListViewController: UserListViewModelDelegate {
        func usersLoaded() {
            tableView.reloadData()
        }
        
        func showError(_ error: String) {
            let alert = UIAlertController(title: "Hata", message: error, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default))
            present(alert, animated: true)
        }
    }
