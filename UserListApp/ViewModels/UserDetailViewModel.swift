//
//  UserDetailViewModel.swift
//  UserListApp
//
//  Created by Musa Adıtepe on 27.01.2025.
//

import Foundation

class UserDetailViewModel {
    private let user: User
    
    init(user: User) {
        self.user = user
    }
    
    var name: String {
        return user.name
    }
    
    var email: String {
        return user.email
    }
    
    var phone: String {
        return user.phone
    }
    
    var website: String {
        return user.website
    }
    
    var address: String {
        return "\(user.address.street), \(user.address.suite)\n\(user.address.city), \(user.address.zipcode)"
    }
    
    var company: String {
        return user.company.name
    }
} 
