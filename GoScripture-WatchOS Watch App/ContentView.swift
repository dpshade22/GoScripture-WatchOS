//
//  ContentView.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//

import SwiftUI

struct ContentView: View {
    @State var scriptures: [Scripture] = []
    @State var searchText: String = ""
    @State var searchBy: String = "verse"
    @State var isLoading: Bool = false
    @State var crownValue: Double = 0

    var searchOptions = ["verse", "chapter", "passage"]

    var body: some View {
        NavigationView {
            VStack {
                TabView {
                    SearchView(scriptures: $scriptures, searchBy: searchBy)
                    ForEach(scriptures) { result in
                        ScriptureView(verse: result.verse, location: result.location)
                            .tabItem {
                                    Label("Next Scripture", systemImage: "book")
                                }
                    }
                }
                .tabViewStyle(.verticalPage)
                .navigationTitle("Go Scripture")
            }
        }
        .digitalCrownRotation($crownValue)
    }
}

#Preview {
    ContentView()
}
