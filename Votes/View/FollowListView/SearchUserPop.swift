//
//  UserListPop.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/17.
//

import SwiftUI

struct SearchUserPop: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var interactor = SearchUserInteractor(profileRepository: RepositoryDependency.profileRepository)
    @State private var search = ""
    let onTapCell: (OtherProfile) -> Void
    
    init(onTapCell: @escaping (OtherProfile) -> Void) {
        self.onTapCell = onTapCell
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Text("友だち検索")
                .padding(.top, 40)
            
            SearchBar(text: $search) { param in
                interactor.searchProfiles(param: param)
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
            
            ScrollView {
                ForEach(interactor.profiles, id: \.self) { profile in
                    Button {
                        onTapCell(profile)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        UserProfileCell(profile: profile)
                    }
                }
            }
        }
    }
}

struct SearchUserPop_Previews: PreviewProvider {
    static var previews: some View {
        SearchUserPop(onTapCell: {_ in})
    }
}
