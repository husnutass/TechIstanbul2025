//
//  DetailView.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 4.09.2025.
//

import SwiftUI

struct DetailView: View {
    @StateObject private var viewModel = DetailViewModel()
    let id: String
    
    var body: some View {
        VStack {
            if let user = viewModel.user {
                VStack(alignment: .leading) {
                    AsyncImage(url: URL(string: user.avatarUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView("Loading...")
                    }
                    .frame(width: 100, height: 100)

                    HStack {
                        Text(user.name)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Text(user.bio)
                            .font(.body)
                        
                        Spacer()
                    }
                    
                    Spacer()
                }
                .padding()
            } else {
                ProgressView()
            }
            
        }
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchUser(withId: id)
        }
    }
}

#Preview {
    NavigationStack {
        DetailView(id: "dsadsad")
    }
}
