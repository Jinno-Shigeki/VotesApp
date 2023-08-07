//
//  SearchBar.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/17.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    let onSubmit: (String) -> Void
    
    init(text: Binding<String>, onSubmit: @escaping (String) -> Void) {
        self._text = text
        self.onSubmit = onSubmit
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color(red: 239 / 255,
                                green: 239 / 255,
                                blue: 241 / 255))
                    .frame(height: 36)
                
                HStack(spacing: 6) {
                    Spacer()
                        .frame(width: 0)
            
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.gray)
                    
                    TextField("Search", text: $text)
                        .onSubmit {
                            onSubmit(text)
                        }
                    
                    if !text.isEmpty {
                        Button {
                            text.removeAll()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.gray)
                        }
                        .padding(.trailing, 6)
                    }
                }
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    @State static var text = "asda"
    static var previews: some View {
        SearchBar(text: $text, onSubmit: {_ in})
    }
}
