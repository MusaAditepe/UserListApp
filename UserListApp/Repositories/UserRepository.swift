//
//  UserRepository.swift
//  UserListApp
//
//  Created by Musa Adıtepe on 27.01.2025.
//

import Foundation

protocol UserRepositoryProtocol {
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void)
}

class UserRepository: UserRepositoryProtocol {
    private let networkManager: NetworkManager
    
    init(networkManager: NetworkManager = .shared) {
        self.networkManager = networkManager
    }
    
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        networkManager.fetchUsers(completion: completion)
    }
} 
