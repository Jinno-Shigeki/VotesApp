//
//  ListSelectButton.swift
//  Votes
//
//  Created by 神野成紀 on 2023/05/13.
//

import SwiftUI

struct ListSelectButton: View {
    var action: () -> Void
    var title: String
    var selfIndex: Int
    
    @Binding var ownerIndex: Int
    
    init(action: @escaping () -> Void, title: String, selfIndex: Int, ownerIndex: Binding<Int>) {
        self.action = action
        self.title = title
        self.selfIndex = selfIndex
        self._ownerIndex = ownerIndex
    }
    
    var body: some View {
        Button {
            action()
            ownerIndex = selfIndex
        } label: {
            VStack {
                Text(title)
                    .foregroundColor(.black)
                    .frame(width: UIScreen.main.bounds.width/2, height: 18)
                
                Divider()
                    .frame(height: 2)
                    .background(ownerIndex == selfIndex ? Color.black: Color.clear)
            }
        }
    }
}

struct ListSelectButton_Previews: PreviewProvider {
    struct ButtonTest: View {
        @State private var ownerIndex = 0
        
        var body: some View {
            HStack {
                ListSelectButton(action: {}, title: "友達", selfIndex: 0, ownerIndex: $ownerIndex)
                ListSelectButton(action: {}, title: "グループ", selfIndex: 1, ownerIndex: $ownerIndex)
            }
        }
    }
    
    static var previews: some View {
        ButtonTest()
    }
}
