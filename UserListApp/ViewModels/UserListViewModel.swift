//
//  UserListViewModel.swift
//  UserListApp
//
//  Created by Musa Adıtepe on 27.01.2025.
//

import Foundation

protocol UserListViewModelDelegate: AnyObject {
    func usersLoaded()
    func showError(_ error: String)
}

class UserListViewModel {
    private let repository: UserRepositoryProtocol
    weak var delegate: UserListViewModelDelegate?
    
    private(set) var users: [User] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.usersLoaded()
            }
        }
    }
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    func fetchUsers() {
        repository.getUsers { [weak self] result in
            switch result {
            case .success(let users):
                self?.users = users
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.delegate?.showError(error.localizedDescription)
                }
            }
        }
    }
    
    func getUserAt(_ index: Int) -> User {
        return users[index]
    }
    
    func numberOfUsers() -> Int {
        return users.count
    }
} 
