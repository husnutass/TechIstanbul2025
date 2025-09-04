//
//  DetailViewModel.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 4.09.2025.
//

import Foundation

@MainActor
final class DetailViewModel: ObservableObject {
    
    private let apiManager = APIManager()
    
    @Published var user: User?
    
    func fetchUser(withId id: String) async {
        do {
            user = try await apiManager.fetchData(urlString: "https://userlistapi.netlify.app/api/users/\(id)")
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
