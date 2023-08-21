//
//  ProfilePop.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/23.
//

import SwiftUI
import Profile

struct ProfilePop: View {
    @Binding var isPopShow: Bool
    let context: ProfilePopContext
    let profile: IProfileBase
    let onConfirm: () -> Void
    let onCnacel: () -> Void
    
    init(isPopShow: Binding<Bool>, context: ProfilePopContext, profile: IProfileBase, onConfirm: @escaping () -> Void, onCnacel: @escaping () -> Void = {}) {
        self._isPopShow = isPopShow
        self.context = context
        self.profile = profile
        self.onConfirm = onConfirm
        self.onCnacel = onCnacel
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            Color.black.opacity(0.3)
                .onTapGesture {
                    isPopShow = false
                }
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                Text(context.title)
                    .font(.system(size: 20, weight: .bold))
                
                if !context.message.isEmpty {
                    Text(context.message)
                        .font(.system(size: 14))
                        .padding(.top, 20)
                }
                
                ProfileImage(base64String: profile.image)
                    .padding(.top, 32)
                
                Text("\(profile.name)")
                    .font(.system(size: 18, weight: .bold))
                    .padding(.top, 8)
                Text("\(profile.id)")
                    .font(.system(size: 12, weight: .thin))
                    .padding(.top, 8)
                
                Button {
                    Task {
                        onConfirm()
                    }
                } label: {
                    Text(context.confirmStr)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color("ButtonColor"))
                        .cornerRadius(4)
                }
                .padding(.top, 24)
                .padding(.horizontal, 80)
                
                Button {
                    onCnacel()
                    isPopShow = false
                } label: {
                    Text(context.cancelStr)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(.black.opacity(0.8))
                        .cornerRadius(4)
                }
                .padding(.top, 24)
                .padding(.horizontal, 80)
            }
            .padding(.vertical, 40)
            .background(.white)
            .cornerRadius(20)
            .padding(.horizontal, 12)
        }
    }
}

struct ProfilePop_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ProfilePop(isPopShow: .constant(false), context: ProfilePopContextKey.profileCreate.content, profile: ProfileEditor(id: "aaaa", name: "aaaa", message: "aaaa", iconImageString: ""), onConfirm: {}, onCnacel: {})
        }

        ProfilePop(isPopShow: .constant(false), context: ProfilePopContextKey.vote.content, profile: ProfileEditor(id: "aaaa", name: "aaaa", message: "aaaa", iconImageString: ""), onConfirm: {}, onCnacel: {})
    }
}
