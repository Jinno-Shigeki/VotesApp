//
//  SignInView.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/14.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var interactor = SignInInteractor(accountRepository: RepositoryDependency.accountRepository)
    @Environment(\.presentationMode) var presentationMode
    @State var input = Input()
    
    let signIn: (Bool) -> Void
    
    init(signIn: @escaping (Bool) -> Void) {
        self.signIn = signIn
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Sign In")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color("ButtonColor"))
            
            Text("Your email")
                .padding(.top, 35)
            Group {
                TextField(text: $input.email) {
                    Text("Your email")
                }
                .padding(.horizontal, 12)
            }
            .frame(height: 46)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)
            .padding(.top, 8)
            
            Text("Password")
                .padding(.top, 20)
            Group {
                TextField(text: $input.password) {
                    Text("Password")
                }
                .padding(.horizontal, 12)
            }
            .frame(height: 46)
            .background(Color.blue.opacity(0.1))
            .cornerRadius(8)
            .padding(.top, 8)
            
            
            Button {
                Task {
                    await interactor.signIn(email: input.email, password: input.password) { isUserID in
                        signIn(isUserID)
                    }
                }
            } label: {
                Text("Sign in")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(Color("ButtonColor"))
                    .cornerRadius(8)
            }
            .padding(.top, 40)
        }
        .padding(.horizontal, 48)
        .padding(.top, 20)
    }
}

extension SignInView {
    struct Input {
        var email = ""
        var password = ""
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Spacer()
            
            VStack {
                Spacer()
                SignInView() {_ in 
                    
                }
                .background(Color(.white))
                .cornerRadius(40)
            }
        }
        .background(Color("ButtonColor"))
    }
}
