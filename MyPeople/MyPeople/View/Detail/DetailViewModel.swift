//
//  DetailViewModel.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 4.09.2025.
//

import Foundation

final class DetailViewModel: BaseViewModel<UserService> {
    
    @Published var user: User?
    
    func fetchUser(withId id: String) async {
        do {
            user = try await service.getUser(withId: id)
        } catch {
            print(error.localizedDescription)
        }
    }
}
