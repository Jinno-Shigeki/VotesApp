//
//  Question.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/22.
//

import SwiftUI

struct Question: View {
    let qustion: String
    
    var body: some View {
        VStack(spacing: 0) {
            image
                .resizable()
                .frame(width: 40, height: 40)
                .padding(.top, 20)
                .foregroundColor(imageColor)
            
            Text(text)
                .foregroundColor(textColor)
                .padding(.top, 16)
            
            if qustion.isEmpty {
                Text("質問の更新まであと？？分")
                    .foregroundColor(textColor)
                    .padding(.top, 10)
            }
            
            Spacer()
            
            HStack(spacing: 0) {
                Spacer()
                
                if !qustion.isEmpty {
                    Button {
                        
                    } label: {
                        Text("スキップ")
                    }
                    .tint(Color.init("ButtonColor"))
                }
            }
            .padding(.trailing, 16)
            .padding(.bottom, 12)
        }
        .frame(maxWidth: .infinity)
        .frame(height: 188)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(textColor, lineWidth: 3)
        )
        .background(background)
        .cornerRadius(12)
    }
}

extension Question {
    var text: String {
        if qustion.isEmpty {
            return "次の投票時間まで待っててね"
        }
        return qustion
    }
    
    var textColor: Color {
        if qustion.isEmpty {
            return Color.black
        }
        return Color.init("ButtonColor")
    }
    
    var imageColor: Color {
        if qustion.isEmpty {
            return Color.black
        }
        return Color.init("ButtonColor")
    }
    
    var background: Color {
        if qustion.isEmpty {
            return Color.gray.opacity(0.3)
        }
        return Color.init("ButtonColor").opacity(0.12)
    }
    
    var image: Image {
        if qustion.isEmpty {
            return Image(systemName: "ellipsis.message.fill")
        }
        return Image(systemName: "questionmark.circle.fill")
    }
}

struct Question_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Question(qustion: "")
            Question(qustion: "あなたの友達の中で最も優しい人は誰？")
        }
    }
}
