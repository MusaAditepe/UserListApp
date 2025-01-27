//
//  NetworkManager.swift
//  UserListApp
//
//  Created by Musa Adıtepe on 27.01.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    case serverError(String)
}

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://jsonplaceholder.typicode.com"
    
    private init() {}
    
    func fetchUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        guard let url = URL(string: "\(baseURL)/users") else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.serverError(error.localizedDescription)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                completion(.success(users))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
} 
