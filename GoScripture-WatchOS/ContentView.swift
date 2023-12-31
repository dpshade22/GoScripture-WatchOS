//
//  ContentView.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var resultsViewModel = ResultsViewModel()
    
    @State var selectedVerse = 0
    @State private var searchBy: String = "verse"
    @State private var showResults: Bool = false
    @State private var tabSelection = 0
    @State private var isSubscribed: Bool = true

    var body: some View {
        TabView(selection: $tabSelection) {
                SearchView(resultsViewModel: resultsViewModel, tabSelection: $tabSelection, selectedVerse: $selectedVerse)
                    .tabItem {
                        Text("Search")
                    }
                    .tag(0)
            
            if resultsViewModel.scriptures.count > 0 {
                ResultsTabView(resultsViewModel: resultsViewModel, selectedVerse: $selectedVerse)
                    .tabItem {
                        Text("ResultsTabView")
                    }
                    .tag(1)
                ResultsView(resultsViewModel: resultsViewModel, selectedVerse: $selectedVerse, selectedTab: $tabSelection)
                    .tabItem {
                        Text("List")
                    }
                    .tag(2)
            }
        }
        .onChange(of: tabSelection) {
            WKInterfaceDevice.current().play(.click)
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
}

#Preview {
    ContentView()
}
