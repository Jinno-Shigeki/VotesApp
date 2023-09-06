//
//  CustomAlertView.swift
//  Votes
//
//  Created by 神野成紀 on 2023/06/19.
//

//import SwiftUI
//
//struct CustomAlertView: ViewModifier {
//    @Binding var alertObject: AlertObject
//    let retry: (() -> Void)?
//
//    func body(content: Content) -> some View {
//        content
//            .alert(alertObject.title, isPresented: .constant(alertObject.isAlert)) {
//                Button {
//
//                } label: {
//                    Text("キャンセル")
//                }
//                if (retry != nil) {
//                    Button {
//                        retry!()
//                    } label: {
//                        Text("リトライ")
//                    }
//                }
//            } message: {
//                Text(alertObject.message)
//            }
//    }
//}
//
//extension View {
//    func customAlert(for alertObject: Binding<AlertObject>) -> some View {
//        modifier(CustomAlertView(alertObject: alertObject, retry: nil))
//    }
//
//    func customAlert(for alertObject: Binding<AlertObject>, retry: @escaping() -> Void) -> some View {
//        modifier(CustomAlertView(alertObject: alertObject, retry: retry))
//    }
//}
