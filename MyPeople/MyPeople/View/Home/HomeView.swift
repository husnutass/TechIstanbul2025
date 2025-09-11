//
//  HomeView.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 4.09.2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    @State private var showAddUserSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.users) { user in
                        NavigationLink {
                            DetailView(id: user.id)
                        } label: {
                            Text(user.name)
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            Task {
                                await viewModel.deleteUser(at: index)
                            }
                        }
                    }
                }
                
                Button {
                    showAddUserSheet = true
                } label: {
                    Text("Add User")
                }

            }
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.automatic)
            .refreshable {
                await viewModel.getUsers()
            }
            .sheet(isPresented: $showAddUserSheet, content: {
                CreateUserView()
            })
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
