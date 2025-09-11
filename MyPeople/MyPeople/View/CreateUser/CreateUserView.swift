//
//  CreateUserView.swift
//  MyPeople
//
//  Created by Hüsnü Taş on 11.09.2025.
//

import SwiftUI
import PhotosUI

struct CreateUserView: View {
    @StateObject private var viewModel = CreateUserViewModel()
    
    @State private var name: String = ""
    @State private var bio: String = ""
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var isAdmin: Bool = false
    
    @State private var image: Data?
    @State private var imageBase64: String?
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                userInfoSection()
                
                Button {
                    guard let imageBase64 else { return }
                    viewModel.userRequest = User(
                        id: UUID().uuidString,
                        name: name,
                        bio: bio,
                        avatarUrl: imageBase64,
                        isChecked: isAdmin
                    )
                    
                    Task {
                        await viewModel.createUser()
                    }
                } label: {
                    Text("Create User")
                }
                
            }
            .navigationTitle("Create User")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}

private extension CreateUserView {
    @ViewBuilder
    func userInfoSection() -> some View {
        Section("User Information") {
            TextField("Name", text: $name)
            
            TextField("Bio", text: $bio)
            
            HStack {
                PhotosPicker("Choose Image", selection: $photosPickerItem)
                    .onChange(of: photosPickerItem) { oldValue, newValue in
                        Task {
                            image = try? await newValue?.loadTransferable(type: Data.self)
                            imageBase64 = "data:image/jpeg;base64,\(image?.base64EncodedString() ?? "")"
                        }
                    }
                
                Spacer()
                
                AsyncImage(url: URL(string: imageBase64 ?? "")) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Image(systemName: "person.circle")
                }
                .frame(height: 20)

            }
            
            Toggle("Is Admin", isOn: $isAdmin)
        }
    }
}

#Preview {
    CreateUserView()
}
