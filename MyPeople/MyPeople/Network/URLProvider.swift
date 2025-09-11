//
//  URLProvider.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 11.09.2025.
//

import Foundation

final class URLProvider {
    
    private var baseURL: URL? {
        URL(string: "https://userlistapi.netlify.app/api")
    }
    
    func url(for endpoint: Endpoint, path: String? = nil) -> URL? {
        var url = baseURL?.appending(path: endpoint.rawValue)
        if let path {
            url = url?.appending(path: path)
        }
        return url
    }
}
