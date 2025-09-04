//
//  HomeViewModel.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 4.09.2025.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    
    private let apiManager = APIManager()
    
    @Published var users: [User] = []
    
    func getUsers() async {
        do {
            users = try await apiManager.fetchData(urlString: "https://userlistapi.netlify.app/api/users")
        } catch {
            print(error.localizedDescription)
        }
    }
}
