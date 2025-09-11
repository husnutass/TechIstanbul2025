//
//  APIManager.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 4.09.2025.
//

import Foundation

final class APIManager {
    
    static let shared = APIManager()
    
    private let urlProvider = URLProvider()
    
    private init() {}
    
    func fetchData<T: Decodable, B: Encodable>(
        endpoint: Endpoint,
        path: String? = nil,
        method: HTTPMethod = .get,
        body: B = EmptyBody()
    ) async throws -> T {
        guard let url = urlProvider.url(for: endpoint, path: path) else { throw APIError.invalidURL }
        
        // urlRequest
        var urlRequest = URLRequest(url: url)
        
        // method
        urlRequest.httpMethod = method.rawValue
        
        print(#function, "URL: \(url)")
        print(#function, "URL Request: \(urlRequest)")
        
        // headers
        urlRequest.addValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        do {
            // body
            if !(body is EmptyBody) {
                print(#function, "Body: \(body)")
                urlRequest.httpBody = try JSONEncoder().encode(body)
            }
            
            // url session
            let (data, _) = try await URLSession.shared.data(for: urlRequest)
            
            // let stringData = String(data: data, encoding: .utf8)
            // print("String Data: \(stringData ?? "")")
            
            // decode data
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
