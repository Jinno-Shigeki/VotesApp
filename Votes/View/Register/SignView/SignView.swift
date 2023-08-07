//
//  SignInView.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/14.
//

import SwiftUI

struct SignView: View {
    @EnvironmentObject var enviroment: CompleteRegister
    @State private var presentation = Presentation()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer()
                
                Button {
                    presentation.signIn = true
                } label: {
                    Text("Sign in")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .background(Color("ButtonColor"))
                        .cornerRadius(8)
                }
                .sheet(isPresented: $presentation.signIn) {
                    SignInView() { isUserID in
                        selectPresentation(isUserID: isUserID)
                    }
                    .presentationDetents([.medium])
                }
                
                Button {
                    presentation.signUp = true
                } label: {
                    Text("Sign up")
                        .foregroundColor(Color("ButtonColor"))
                        .frame(maxWidth: .infinity, maxHeight: 55)
                        .background(.white)
                        .cornerRadius(8)
                }
                .padding(.top, 16)
                .sheet(isPresented: $presentation.signUp) {
                    SignUpView() {
                        presentation.signUp = false
                        presentation.isProfileEdit = true
                    }
                    .presentationDetents([.medium])
                }
            }
            .padding(.horizontal, 55)
            .padding(.bottom, 110)
            .background(Color.mint)
            .navigationDestination(isPresented: $presentation.isProfileEdit) {
                ProfileRegisterView()
                    .environmentObject(enviroment)
            }
        }
    }
    
    func selectPresentation(isUserID: Bool) {
        if isUserID {
            presentation.signIn = false
            enviroment.completeRegister()
        }
        presentation.signIn = false
        presentation.isProfileEdit = true
    }
}

extension SignView {
    struct Presentation {
        var signIn = false
        var signUp = false
        var isProfileEdit = false
    }
}

struct SignView_Previews: PreviewProvider {
    static var previews: some View {
        SignView()
            .environmentObject(CompleteRegister())
    }
}
