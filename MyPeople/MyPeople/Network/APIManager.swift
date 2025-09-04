//
//  APIManager.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 4.09.2025.
//

import Foundation

final class APIManager {
    
    func fetchData<T: Decodable>(urlString: String) async throws -> T {
        guard let url = URL(string: urlString) else { throw APIError.invalidURL }
        let urlRequest = URLRequest(url: url)
        
        print("URL: \(urlString)")
        print("URL Request: \(urlRequest)")
        
        do {
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            
            let stringData = String(data: data, encoding: .utf8)
            print("String Data: \(stringData ?? "")")
            
            let decodedData = try JSONDecoder().decode(T.self, from: data)
            
            return decodedData
        } catch {
            throw error
        }
    }
    
    
    
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let urlString = "https://userlistapi.netlify.app/api/users"
        guard let url = URL(string: urlString) else { return }
        let urlRequest = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error {
                print(error.localizedDescription)
                completion(.failure(error))
            }
            
            guard let data else { return }
            do {
                let users = try JSONDecoder().decode([User].self, from: data)
                DispatchQueue.main.async {
                    completion(.success(users))
                }
            } catch {
                print(error.localizedDescription)
                completion(.failure(error))
            }
        }.resume()
    }
}


enum APIError: Error {
    case invalidURL
    case decodingFailed
    case networkError(Error)
}
