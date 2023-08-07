//
//  SignUpView.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/14.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var interactor = SignUpInteractor(accountRepository: RepositoryDependency.accountRepository)
    @Environment(\.presentationMode) var presentationMode
    @State var input = Input()
    
    let signUp: () -> Void
    
    init(signUp: @escaping () -> Void) {
        self.signUp = signUp
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Sign Up")
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
                    await interactor.signUp(email: input.email, pass: input.password) {
                        presentationMode.wrappedValue.dismiss()
                        withAnimation {
                            signUp()
                        }
                        
                    }
                }
            } label: {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, maxHeight: 55)
                    .background(Color("ButtonColor"))
                    .cornerRadius(8)
            }
            .padding(.top, 40)
        }
        .padding(.horizontal, 48)
        .customAlert(for: $interactor.alertObject)
    }
}

extension SignUpView {
    struct Input {
        var email = ""
        var password = ""
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Spacer()
            
            VStack {
                Spacer()
                SignUpView() {
                    
                }
                .background(Color(.white))
                .cornerRadius(40)
            }
        }
        .background(Color("ButtonColor"))
    }
}
