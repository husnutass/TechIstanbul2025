//
//  HomeViewModel.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 4.09.2025.
//

import Foundation

final class HomeViewModel: BaseViewModel<UserService> {
        
    @Published var users: [User] = []
    
    func getUsers() async {
        do {
            users = try await service.getUsers()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteUser(at index: Int) async {
        let idToDelete = users[index].id
        
        do {
            let _ = try await service.deleteUser(withId: idToDelete)
        } catch {
            print(error.localizedDescription)
        }
    }
}
