//
//  ContentView.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/10.
//

import SwiftUI
import CoreData
import Profile

struct FollowListView: View {
    @StateObject private var interactor = FollowListInteractor(profileRepository: RepositoryDependency.profileRepository)
    @State var path = NavigationPath()
    @State private var search = ""
    @State private var isPopShow = false

    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 0) {
                ListSelectTab()

                ScrollView {
                    ForEach(interactor.followingProfiles, id: \.self) { profile in
                        Button {
                            path.append(profile)
                        } label: {
                            UserProfileCell(profile: profile)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button(action: {
                        isPopShow.toggle()
                    }){
                        Image(systemName: "person.fill.badge.plus")
                            .foregroundColor(.black)
                    }
                }
            }
            .searchable(text: $search,
                        placement: .navigationBarDrawer(displayMode: .always),
                        prompt: "友だちを検索")
            .onSubmit(of: .search) {
                // filter
            }
            .sheet(isPresented: $isPopShow) {
                SearchUserPop() { cell in
                    path.append(cell)
                }
                .presentationDetents([.height((UIScreen.main.bounds.height/3)*2)])
            }
            .task {
                interactor.listFollowingProfiles()
            }
            .navigationDestination(for: FollowingProfile.self, destination: { data in
                OtherProfileView(userID: data.id, isFollowing: true)
            })
            .navigationDestination(for: OtherProfile.self, destination: { data in
                OtherProfileView(userID: data.id, isFollowing: false)
            })
            .navigationTitle("友だちリスト")
            .navigationBarTitleDisplayMode(.inline)
            .accentColor(.black)
        }
    }
}

struct FollowListView_Previews: PreviewProvider {
    static var previews: some View {
        FollowListView()
    }
}
