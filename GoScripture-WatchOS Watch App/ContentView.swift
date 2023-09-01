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
            ZStack {
                TabView {
                    SearchView(scriptures: $scriptures, searchBy: searchBy)
                        
                    ForEach(scriptures) { result in
                        ScriptureView(verse: result.verse, location: result.location)
                    }
                }
                .tabViewStyle(.verticalPage)
                .navigationTitle("Go Scripture")
            }
            
            .background(Material.thick)
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color.brown, Color.gray]),
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
        }
        .digitalCrownRotation($crownValue)
    }
}

#Preview {
    ContentView()
}
