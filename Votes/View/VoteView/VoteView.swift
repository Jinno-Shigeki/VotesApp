//
//  VoteView.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/22.
//

import SwiftUI

struct VoteView: View {
    @StateObject private var interactor = VoteInteractor(
        voteRepository: RepositoryDependency.voteRepository,
        profileRepository: RepositoryDependency.profileRepository,
        followProfileRepository: RepositoryDependency.followProfileRepository,
        questionRepository: RepositoryDependency.questionRepository)
    @State private var searchParam = ""
    @State private var question = ""
    @State private var popCreater = PopCreater(isActive: false)
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Question(qustion: question)
                        
                        SearchBar(text: $searchParam) { param in
                            
                        }
                        .padding(.top, 20)
                    }
                    .padding(.horizontal, 16)
                    
                    ListSelectTab()
                        .padding(.top, 20)
                    
                    ScrollView {
                        ForEach(interactor.followingProfiles, id: \.self) { profile in
                            HStack(alignment: .top, spacing: 0) {
                                Button {
                                    
                                } label: {
                                    UserProfileCell(profile: profile)
                                }
                                
                                Button {
                                    popCreater.active(base: profile)
                                } label: {
                                    Text("投票する")
                                        .frame(width: 100, height: 35)
                                        .foregroundColor(.white)
                                        .background(Color.init(uiColor: UIColor(named: "ButtonColor")!))
                                        .padding(.top, 20)
                                        .padding(.trailing, 12)
                                }
                                .cornerRadius(4)
                            }
                        }
                    }
                }
                
                if popCreater.isActive {
                    ProfilePop(isPopShow: $popCreater.isActive,
                               context: ProfilePopContextKey.vote.content,
                               profile: popCreater.profileBase!) {
                        interactor.vote(votedProfile: popCreater.profileBase!, question: question) {
                            popCreater.inActive()
                        }
                    }
                }
            }
        }
        .task {
            interactor.getFollowingProfileBases()
            question = interactor.getQuestion()
        }
    }
}

extension VoteView {
    struct PopCreater {
        var isActive: Bool
        var profileBase: ProfileBase?
        
        init(isActive: Bool, profileBase: ProfileBase? = nil) {
            self.isActive = isActive
            self.profileBase = profileBase
        }
        
        mutating func active(base: ProfileBase) {
            isActive = true
            profileBase = base
        }
        
        mutating func inActive() {
            isActive = false
            profileBase = nil
        }
    }
}

struct VoteView_Previews: PreviewProvider {
    static var previews: some View {
        VoteView()
    }
}
