//
//  UserService.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 11.09.2025.
//

import Foundation

final class UserService: BaseService {
        
    func getUsers() async throws -> Users {
        do {
            return try await apiManager.fetchData(endpoint: .users)
        } catch {
            throw error
        }
    }
    
    func getUser(withId id: String) async throws -> User {
        do {
            return try await apiManager.fetchData(endpoint: .users, path: id)
        } catch {
            throw error
        }
    }
    
    func deleteUser(withId id: String) async throws -> DeleteUser {
        do {
            return try await apiManager.fetchData(endpoint: .users, path: id, method: .delete)
        } catch {
            throw error
        }
    }
    
    func createUser(_ user: User) async throws -> User {
        do {
            return try await apiManager.fetchData(endpoint: .users, method: .post, body: user)
        } catch {
            throw error
        }
    }
}
