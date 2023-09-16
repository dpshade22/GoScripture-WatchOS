////
////  StartView.swift
////  GoScripture-WatchOS Watch App
////
////  Created by Dylan Price Shade on 8/31/23.
////
//
//import SwiftUI
//
//struct StartView: View {
//    @Binding var scriptures: [Scripture]
//    @Binding var searchBy: String
//    
//    var body: some View {
//        GeometryReader { geometry in
//            VStack(spacing: 5) {
//                NavigationLink(destination: ContentView(scriptures: searchBy: "verse")) {
//                    Text("Verse")
//                        .frame(width: geometry.size.width - 20, height: 50)
//                        .background(Color(red: 0.5, green: 0.9, blue: 1))
//                        .foregroundColor(Color.white)
//                        .cornerRadius(10)
//                }
//                .buttonStyle(PlainButtonStyle())
//
//                NavigationLink(destination: ContentView(searchBy: "passage")) {
//                    Text("Passage")
//                        .frame(width: geometry.size.width - 20, height: 50)
//                        .background(Color(red: 0.5, green: 0.9, blue: 0.8))
//                        .foregroundColor(Color.white)
//                        .cornerRadius(10)
//                }
//                .buttonStyle(PlainButtonStyle())
//
//                NavigationLink(destination: ContentView(scriptures: $scriptures, searchBy: "chapter")) {
//                    Text("Chapter")
//                        .frame(width: geometry.size.width - 20, height: 50)
//                        .background(Color(red: 0.5, green: 0.8, blue: 0.6))
//                        .foregroundColor(Color.white)
//                        .cornerRadius(10)
//                }
//                .buttonStyle(PlainButtonStyle())
//            }
//            .padding()
//        }
//    }
//}
//
//struct StartView_Previews: PreviewProvider {
//    static var previews: some View {
//        StartView(scriptures: .constant([]), searchBy: .constant("verse"))
//    }
//}
