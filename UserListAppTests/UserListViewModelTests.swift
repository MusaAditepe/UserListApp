import XCTest
@testable import UserListApp

// MARK: - Mock Repository
class MockUserRepository: UserRepositoryProtocol {
    var users: [User]?
    var error: NetworkError?
    
    func getUsers(completion: @escaping (Result<[User], NetworkError>) -> Void) {
        if let error = error {
            completion(.failure(error))
        } else if let users = users {
            completion(.success(users))
        }
    }
}

class UserListViewModelTests: XCTestCase {
    var sut: UserListViewModel!
    var mockRepository: MockUserRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockUserRepository()
        sut = UserListViewModel(repository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testFetchUsersSuccess() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch users success")
        let mockUsers = [
            User(id: 1,
                 name: "Test User",
                 username: "testuser",
                 email: "test@test.com",
                 phone: "1234567890",
                 website: "test.com",
                 address: Address(street: "Test St",
                                suite: "1",
                                city: "Test City",
                                zipcode: "12345",
                                geo: Geo(lat: "0", lng: "0")),
                 company: Company(name: "Test Co",
                                catchPhrase: "Test Phrase",
                                bs: "Test BS"))
        ]
        
        let mockDelegate = MockUserListViewModelDelegate(expectation: expectation)
        sut.delegate = mockDelegate
        mockRepository.users = mockUsers
        
        // When
        sut.fetchUsers()
        
        // Then
        wait(for: [expectation], timeout: 2.0)
        XCTAssertEqual(sut.numberOfUsers(), 1)
        XCTAssertEqual(sut.getUserAt(0).name, "Test User")
    }
    
    func testFetchUsersFailure() {
        // Given
        let expectation = XCTestExpectation(description: "Fetch users failure")
        mockRepository.error = .noData
        
        let mockDelegate = MockUserListViewModelDelegate(expectation: expectation)
        sut.delegate = mockDelegate
        
        // When
        sut.fetchUsers()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(mockDelegate.didShowError)
    }
}

class MockUserListViewModelDelegate: UserListViewModelDelegate {
    let expectation: XCTestExpectation
    var didShowError = false
    
    init(expectation: XCTestExpectation) {
        self.expectation = expectation
    }
    
    func usersLoaded() {
        print("Users loaded called")
        expectation.fulfill()
    }
    
    func showError(_ error: String) {
        print("Error showed: \(error)")
        didShowError = true
        expectation.fulfill()
    }
} 
