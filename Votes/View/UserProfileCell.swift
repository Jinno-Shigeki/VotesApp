//
//  UserProfileCell.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/10.
//

import SwiftUI
import Profile

struct UserProfileCell: View {
    let profile: any IProfileBase

    init(profile: any IProfileBase) {
        self.profile = profile
    }

    var body: some View {
        Group {
            HStack {
                ProfileImage(base64String: profile.image, width: 50, height: 50)

                VStack(alignment: .leading, spacing: 0) {
                    Text(profile.name)
                        .font(Font.system(size: 16, weight: .medium))
                        .padding(.bottom, 8)
                    Text(profile.id)
                        .font(Font.system(size: 11, weight: .light))
                }

                Spacer()
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
        }
    }
}

struct UserProfileCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            UserProfileCell(profile: FollowerProfile(id: "@takumu0151", name: "Takumu Matsumoto", image: ""))
        }
    }
}
