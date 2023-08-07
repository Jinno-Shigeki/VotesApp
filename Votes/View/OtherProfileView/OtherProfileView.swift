//
//  UserProfileView.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/14.
//

import SwiftUI

struct OtherProfileView: View {
    @StateObject var interactor = OtherProfileInteractor(profileRepository: RepositoryDependency.profileRepository, followRepository: RepositoryDependency.followRepository)
    @State private var isFollowing = false
    private let nowFollowState: Bool
    private let userID: String
    
    init(userID: String, isFollowing: Bool) {
        self.isFollowing = isFollowing
        self.nowFollowState = isFollowing
        self.userID = userID
    }

    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 0) {
                UserProfileDetails(profile: interactor.profile)
                
                Button {
                    isFollowing.toggle()
                    interactor.updateFollowState(isFollowing: isFollowing, nowFollowState: nowFollowState)
                } label: {
                    Text(isFollowing ? "フォロー解除" : "フォローする")
                        .foregroundColor(.white)
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(isFollowing ? Color.black.opacity(0.75) : Color.init("ButtonColor"))
                .cornerRadius(4)
                .padding(.top, 20)
                .padding(.leading, 80)
            }
            .padding(.top, 40)
            .padding(.horizontal, 16)
            
            Divider()
                .padding(.top, 12)
            
            Text(interactor.profile.message)
                .font(.system(size: 12))
                .padding(.horizontal, 16)
                .padding(.top, 12)
            
            Spacer()
        }
        .navigationTitle("")
        .task {
            interactor.getUserProfile(userID: userID)
        }
    }
}

struct OtherProfileView_Previews: PreviewProvider {
    static var previews: some View {
        OtherProfileView(userID: "", isFollowing: true)
    }
}
