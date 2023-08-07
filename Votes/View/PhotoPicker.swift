//
//  PhotoPicker.swift
//  Votes
//
//  Created by 神野成紀 on 2023/07/19.
//

import SwiftUI
import PhotosUI

struct PhotoPicker: View {
    @State private var imageItem: [PhotosPickerItem] = []
    @State var selectImage: (Result<Data, NSError>) -> Void
    
    var body: some View {
        VStack(spacing: 0) {
            PhotosPicker(selection: $imageItem,
                         maxSelectionCount: 1,
                         selectionBehavior: .ordered,
                         matching: .images,
                         preferredItemEncoding: .current,
                         photoLibrary: .shared()) {
                Image(systemName: "camera.fill")
                    .frame(width: 36, height: 36)
                    .tint(Color.init("ButtonColor"))
                    .background(.white)
                    .clipShape(Circle())
                    .shadow(color: .gray.opacity(0.5), radius: 4, x: 2, y:4)
            }
            .onChange(of: imageItem) { newValue in
                if !newValue.isEmpty {
                    load(item: newValue[0])
                }
            }
        }
    }
    
    private func load(item: PhotosPickerItem) {
        item.loadTransferable(type: Data.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let data):
                    guard let data else {
                        selectImage(.failure(NSError(domain: "error", code: 1)))
                        return
                    }
                    selectImage(.success(data))
                case .failure(let err):
                    selectImage(.failure(err as NSError))
                }
            }
        }
    }
}

struct PhotoPicker_Previews: PreviewProvider {
    static var previews: some View {
        PhotoPicker(selectImage: { _ in
            
        })
    }
}
