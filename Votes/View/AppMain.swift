//
//  VotesView.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/15.
//

import SwiftUI

struct AppMain: View {
    @StateObject private var register = CompleteRegister()
    //イニシャライザ
    init(){
        //TabViewの背景色の設定（青色）
        UITabBar.appearance().backgroundColor = UIColor.white
    }
    
    
    var body: some View {
        if !register.isRegister {
            SignView()
                .transition(.slide)
                .environmentObject(register)
        } else {
            TabView {
                VoteView()
                    .tabItem {
                        Image(systemName: "house")
                    }
                
                FollowListView()
                    .tabItem {
                        Image(systemName: "person.2.fill")
                    }
                
                VoteHistoryView()
                    .tabItem {
                        Image(systemName: "tray.fill")
                    }
            }
        }
    }
    
    func isRegister() {
        
    }
}

struct AppMain_Previews: PreviewProvider {
    static var previews: some View {
        AppMain()
    }
}
