//
//  UserProfileDetails.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/14.
//

import SwiftUI
import Profile

struct UserProfileDetails: View {
    var profile: Profile
    
    init(profile: Profile) {
        self.profile = profile
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(alignment: .top, spacing: 0) {
                ProfileImage(base64String: profile.image, width: 80, height: 80)
                
                VStack(alignment: .leading, spacing: 0) {
                    Text(profile.name)
                        .font(.system(size: 16, weight: .bold))
                    Text(profile.id)
                        .font(.system(size: 10, weight: .light))
                    
                    HStack(spacing: 0) {
                        VStack(spacing: 0) {
                            Text("\(profile.following)")
                                .font(.system(size: 16, weight: .bold))
                            Text("following")
                                .font(.system(size: 10))
                        }
                        
                        VStack(spacing: 0) {
                            Text("\(profile.follower)")
                                .font(.system(size: 16, weight: .bold))
                            Text("folllowers")
                                .font(.system(size: 10))
                        }
                        .padding(.leading, 20)
                        
                        VStack(spacing: 0) {
                            Text("\(profile.votes)")
                                .font(.system(size: 16, weight: .bold))
                            Text("votes")
                                .font(.system(size: 10))
                        }
                        .padding(.leading, 20)
                    }
                    .padding(.top, 8)
                }
                .padding(.leading, 12)
                .padding(.top, 8)
                
                Spacer()
            }
            
        }
    }
}

struct UserProfileDetails_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileDetails(profile: Profile(id: "@takumu0151", name: "Takumu Matsumoto", image: "", message: "よろしくね", following: 0, follower: 0, votes: 0))
    }
}
