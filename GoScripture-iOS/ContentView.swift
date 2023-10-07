//
//  ContentView.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//

import SwiftUI
import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var resultsViewModel = ResultsViewModel()
    var apiClient = GoScriptureAPI()

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Search screen
                    SearchBar { searchText in
                        resultsViewModel.fetchData(searchText: searchText, searchBy: "verse")
                    }
                    
                    // TabView with List and FullPage views
                    TabView {
                        // List view
                        List(resultsViewModel.scriptures) { scripture in
                            HStack {
                                TextGradient(text: scripture.location)
                                    .font(.headline)
                                Spacer()
                            }
                            .padding()
                            .listRowBackground(Color("Coffee Brown").opacity(1))
                            .background(Color("Foreground Brown").opacity(0.1))
                            .cornerRadius(8)
                        }
                        .listStyle(.plain)
                        .tag(UUID())
                        
                        // FullPage view
                        FullPageView(scriptures: resultsViewModel.scriptures)
                            .tag(UUID())
                    }
                    .tabViewStyle(PageTabViewStyle())
                }
            }
            .background(Color("Coffee Brown"))
        }
    }
}

struct FullPageView: View {
    var scriptures: [Scripture]

    var body: some View {
        TabView {
            ForEach(scriptures) { scripture in
                VStack {
                    Spacer()
                    TextGradient(text: scripture.location)
                        .font(.title)
                        .padding(.bottom)
                    TextGradient(text: scripture.verse)
                        .font(.body)
                        .padding(.horizontal)
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .rotationEffect(.degrees(270)) // Rotate the TabView
                .padding()
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .rotationEffect(.degrees(-270)) // Rotate the TabView
        .frame(width: UIScreen.main.bounds.width) // Set the frame width to the screen width

    }
}

struct SearchBar: View {
    @State private var searchText: String = ""
    var onSearch: (String) -> Void

    var body: some View {
        TextField("Search", text: $searchText, onCommit: {
            onSearch(searchText)
        })
        .padding(EdgeInsets(top: 13, leading: 16, bottom: 13, trailing: 16))
        .background(Color("Foreground White").opacity(1))
        .foregroundColor(Color("Coffee Brown"))
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color("Coffee Brown"), lineWidth: 1)
        )
        .padding()
    }
}

struct ScriptureView: View {
    var scripture: Scripture
    
    var body: some View {
        VStack {
            Text(scripture.location)
                .font(.title)
                .padding(.bottom)
            Text(scripture.verse)
                .font(.body)
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
