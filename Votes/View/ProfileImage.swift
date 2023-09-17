//
//  ProfileImage.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/21.
//

import SwiftUI

struct ProfileImage: View {
    let imageData: Data
    let width: CGFloat
    let height: CGFloat
    @State var error: NSError? = nil
    
    init(imageData: Data, width: CGFloat = 100, height: CGFloat = 100) {
        self.imageData = imageData
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
        guard let uiImage = UIImage(data: imageData) else {
            error = NSError(domain: "image data decode failure", code: 1)
            return nil
        }
        return uiImage
    }
}

struct ProfileImage_Previews: PreviewProvider {
    static var previews: some View {
        ProfileImage(imageData: Data())
    }
}
