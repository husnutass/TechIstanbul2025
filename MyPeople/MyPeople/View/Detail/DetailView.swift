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
                    HStack {
                        AsyncImage(url: URL(string: user.avatarUrl)) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView("Loading...")
                        }
                        .clipShape(Circle())
                        .overlay(content: {
                            Circle().stroke(Color.black.opacity(0.5), lineWidth: 1)
                        })
                        .frame(width: 100, height: 100)
                        
                        VStack(alignment: .leading) {
                            Text(user.name)
                                .font(.title)
                                .fontWeight(.bold)
                            
                            Text(user.bio)
                                .font(.body)
                        }
                        
                        Spacer()
                    }
                    
                    ScrollView {
                        Text("Some text here dsadkasd lklasd kasdk asdkljjlljk sda ljkasdlk jasdlk jasdlk jasdlk dsadasd")
                            .font(.headline)
                    }
                    
                    Spacer()
                }
                .padding()
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 50))
                .padding()
            } else {
                ProgressView()
            }
            
        }
        .background(Color.secondary.opacity(0.2))
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
