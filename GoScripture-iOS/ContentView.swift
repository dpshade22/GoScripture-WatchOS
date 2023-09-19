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
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("Coffee Brown"), Color("Light Brown")]),
               startPoint: .top,
               endPoint: .bottomTrailing
             )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("test")
            }
            .searchable(text: $searchBy)
            
        }
    }
}

#Preview {
    ContentView()
}
