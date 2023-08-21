//
//  ProfileEditView.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/12.
//

import SwiftUI
import Profile

struct ProfileRegisterView: View {
    @EnvironmentObject private var enviroment: CompleteRegister
    @StateObject private var interactor = ProfileRegisterInteractor(profileRepository: RepositoryDependency.profileRepository)
    @StateObject private var editor = ProfileEditor()
    @State private var isPopShow = false
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Text("プロフィールを入力しましょう")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(Color.init("ButtonColor"))
                        
                        Text("アイコン・ユーザーネーム・自己紹介は後で編集可能です")
                            .font(.system(size: 13))
                            .padding(.top, 4)
                    }
                    
                    VStack(spacing: 0) {
                        Text("アイコン")
                            .font(.system(size: 14, weight: .bold))
                        
                        ZStack(alignment: .bottomTrailing) {
                            ProfileImage(base64String: editor.image)
                            
                            PhotoPicker() { result in
                                pickerImage(result: result)
                            }
                            .offset(x: 18)
                        }
                        .padding(.top, 8)
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("ユーザーネーム（本名推奨）")
                            .font(.system(size: 14, weight: .bold))
                        
                        TextField(text: $editor.name) {
                            Text("名前を入力してください")
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 46)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.top, 4)
                    }
                    .padding(.top, 32)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("ユーザーID")
                            .font(.system(size: 14, weight: .bold))
                        
                        TextField(text: $editor.id) {
                            Text("半角英数字（8文字以上）で入力してください")
                        }
                        .padding(.horizontal, 12)
                        .frame(height: 46)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                        .padding(.top, 4)
                    }
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text("自己紹介")
                            .font(.system(size: 14, weight: .bold))
                        
                        TextEditor(text: $editor.message)
                            .frame(height: 150)
                            .scrollContentBackground(.hidden)
                            .background(Color.blue.opacity(0.1))
                            .cornerRadius(8)
                            .padding(.top, 8)
                    }
                    .padding(.top, 20)
                    
                    Button {
                        isPopShow = true
                    } label: {
                        Text("プロフィールを登録する")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(Color("ButtonColor"))
                            .cornerRadius(8)
                    }
                    .padding(.top, 40)
                }
                .padding(.horizontal, 16)
                .padding(.top, 16)
            }
            
            if isPopShow {
                setPop()
            }
        }
        .navigationTitle("")
        .navigationBarBackButtonHidden(true)
    }
}

extension ProfileRegisterView {
    func setPop() -> some View {
        return ProfilePop(isPopShow: $isPopShow,
        context: ProfilePopContextKey.profileCreate.content,
        profile: editor) {
            interactor.registerProfile(editor: editor) {
                withAnimation {
                    enviroment.completeRegister()
                }
            }
        } onCnacel: {
            
        }
    }
    
    func pickerImage(result: Result<Data, NSError>) {
        switch result {
        case .success(let data):
            editor.image = data.base64EncodedString()
        case .failure(let err):
            print(err)
        }
    }
}

struct ProfileRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileRegisterView()
    }
}
