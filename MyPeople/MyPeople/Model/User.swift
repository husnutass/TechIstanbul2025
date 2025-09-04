//
//  User.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 4.09.2025.
//

import Foundation

typealias Users = [User]

struct User: Codable, Identifiable {
    let id: String
    let name: String
    let bio: String
    let avatarUrl: String
    let isChecked: Bool
}
