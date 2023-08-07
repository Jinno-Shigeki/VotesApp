//
//  VoteHistoryView.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/26.
//

import SwiftUI

struct VoteHistoryView: View {
    @StateObject private var interactor = VoteHistoryInteractor(
        voteRepository: RepositoryDependency.voteRepository,
        profileRepository: RepositoryDependency.profileRepository)
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollView {
                    ForEach(interactor.histories, id: \.self) { vote in
                        VoteHistoryCell(vote: vote)
                            .padding(.horizontal, 12)
                    }
                }
            }
            .navigationTitle("投票履歴")
            .navigationBarTitleDisplayMode(.inline)
        }
        .task {
            interactor.getHistory()
        }
    }
}

struct VoteHistoryView_Previews: PreviewProvider {
    static var previews: some View {
        VoteHistoryView()
    }
}
