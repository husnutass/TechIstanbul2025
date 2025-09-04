//
//  HomeView.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 4.09.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.users) { user in
                    NavigationLink {
                        DetailView(id: user.id)
                    } label: {
                        Text(user.name)
                    }
                }
            }
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.automatic)
            .onAppear {
                // Task {
                //     await viewModel.getUsers()
                // }
            }
            .task {
                await viewModel.getUsers()
            }
        }
    }
}

#Preview {
    HomeView()
}
