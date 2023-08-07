//
//  ListSelectTab.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/13.
//

import SwiftUI

struct ListSelectTab: View {
    @State var ownerIndex = 0
    var body: some View {
        HStack(spacing: 0) {
            ListSelectButton(action: {
                
            }, title: "友達", selfIndex: 0, ownerIndex: $ownerIndex)
            
            
            ListSelectButton(action: {
                
            }, title: "グループ", selfIndex: 1, ownerIndex: $ownerIndex)
        }
    }
}

struct ListSelectTab_Previews: PreviewProvider {
    static var previews: some View {
        ListSelectTab()
    }
}
