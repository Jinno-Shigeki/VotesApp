//
//  VoteHistoryCell.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/26.
//

import SwiftUI
import Vote

struct VoteHistoryCell: View {
    let vote: Vote
    
    init(vote: Vote) {
        self.vote = vote
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(convertDateString(date: vote.createdAt))
            
            Text(vote.question)
                .padding(.top, 16)
            
            HStack(spacing: 0) {
                ProfileImage(base64String: vote.image, width: 30, height: 30)

                Text(vote.id)
                    .padding(.leading, 4)
                Text("に投票しました。")
                
                Spacer()
                
                Text(convertTimeString(date: vote.createdAt))
            }
            .padding(.top, 16)
        }
    }
}

extension VoteHistoryCell {
    func convertDateString(date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ja_JP")
        df.dateFormat = "yyyy年MM月dd日"
        return df.string(from: date)
    }
    
    func convertTimeString(date: Date) -> String {
        let df = DateFormatter()
        df.locale = Locale(identifier: "ja_JP")
        df.dateFormat = "HH:mm"
        return df.string(from: date)
    }
}

struct VoteHistoryCell_Previews: PreviewProvider {
    static var previews: some View {
        VoteHistoryCell(vote: Vote(id: "@tkrmmm",
                                   name: "Takumu Matsumoto",
                                   image: "",
                                   question: "あなたの友達の中で最も優しい人は誰？",
                                   createdAt: Date()))
    }
}
