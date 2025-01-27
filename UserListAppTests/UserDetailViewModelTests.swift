//
//  UserDetailViewModelTests.swift
//  UserListAppTests
//
//  Created by Musa Adıtepe on 27.01.2025.
//

import XCTest
@testable import UserListApp

class UserDetailViewModelTests: XCTestCase {
    var sut: UserDetailViewModel!  // sut = System Under Test
    var mockUser: User!
    
    override func setUp() {
        super.setUp()
        // Test için örnek bir kullanıcı oluşturuyoruz
        mockUser = User(
            id: 1,
            name: "Test User",
            username: "testuser",
            email: "test@test.com",
            phone: "1234567890",
            website: "test.com",
            address: Address(
                street: "Test St",
                suite: "1",
                city: "Test City",
                zipcode: "12345",
                geo: Geo(lat: "0", lng: "0")
            ),
            company: Company(
                name: "Test Co",
                catchPhrase: "Test Phrase",
                bs: "Test BS"
            )
        )
        sut = UserDetailViewModel(user: mockUser)
    }
    
    override func tearDown() {
        sut = nil
        mockUser = nil
        super.tearDown()
    }
    
    func testUserDetailProperties() {
        // Then
        XCTAssertEqual(sut.name, "Test User")
        XCTAssertEqual(sut.email, "test@test.com")
        XCTAssertEqual(sut.phone, "1234567890")
        XCTAssertEqual(sut.website, "test.com")
        XCTAssertEqual(sut.company, "Test Co")
        XCTAssertEqual(sut.address, "Test St, 1\nTest City, 12345")
    }
} 
