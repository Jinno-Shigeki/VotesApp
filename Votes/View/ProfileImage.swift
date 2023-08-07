//
//  ProfileImage.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/21.
//

import SwiftUI

struct ProfileImage: View {
    let base64String: String
    let width: CGFloat
    let height: CGFloat
    @State var error: NSError? = nil
    
    init(base64String: String, width: CGFloat = 100, height: CGFloat = 100) {
        self.base64String = base64String
        self.width = width
        self.height = height
    }
    
    var body: some View {
        if let image = toUIImage() {
            Image(uiImage: image)
                .resizable()
                .frame(width: width, height: height)
                .clipShape(Circle())
        } else {
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: width, height: height)
                .clipShape(Circle())
                .foregroundColor(.black)
        }
    }
    
    func toUIImage() -> UIImage? {
        if base64String.isEmpty {
            return nil
        }
        let data = Data(base64Encoded: base64String)!
        guard let uiImage = UIImage(data: data) else {
            error = NSError(domain: "image data decode failure", code: 1)
            return nil
        }
        return uiImage
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(base64String: "")
    }
}
