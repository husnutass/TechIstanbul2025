//
//  BaseViewModel.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 11.09.2025.
//

import Foundation

@MainActor
class BaseViewModel<S: BaseService>: ObservableObject {
    
    let service: S
    
    init() {
        self.service = S.init()
    }
}
