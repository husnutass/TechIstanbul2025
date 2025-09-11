//
//  CreateUserViewModel.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 11.09.2025.
//

import Foundation

final class CreateUserViewModel: BaseViewModel<UserService> {
    
    var userRequest: User?
    
    func createUser() async {
        guard let userRequest else { return }
        
        do {
            let _ = try await service.createUser(userRequest)
        } catch {
            print(error.localizedDescription)
        }
    }
}
