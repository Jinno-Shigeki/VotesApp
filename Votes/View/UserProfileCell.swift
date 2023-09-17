//
//  UserProfileCell.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/10.
//

import SwiftUI
import Profile

struct UserProfileCell: View {
    let profile: ProfileBase

    init(profile: ProfileBase) {
        self.profile = profile
    }

    var body: some View {
        Group {
            HStack {
                ProfileImage(imageData: profile.image, width: 50, height: 50)

                VStack(alignment: .leading, spacing: 0) {
                    Text(profile.name)
                        .font(Font.system(size: 16, weight: .medium))
                        .padding(.bottom, 8)
                    Text(profile.displayID)
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
            UserProfileCell(profile: ProfileBase(userID: "aaa", displayID: "aaa", name: "aaa", image: Data()))
        }
    }
}
