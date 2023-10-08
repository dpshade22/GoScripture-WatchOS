//
//  ContentView.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var resultsViewModel = ResultsViewModel()
    var apiClient = GoScriptureAPI()
    @State private var searchText: String = ""
    @State private var searchSuggestions: [String] = []

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // Add TextField for search input
                    TextField("For God so loved the world", text: $searchText, onCommit: {
                        resultsViewModel.fetchData(searchText: searchText, searchBy: "verse")
                    })
                    .textFieldStyle(.roundedBorder)
                    .padding()

                    // TabView with List and FullPage views
                    TabView {
                        // List view
                        List {
                            ForEach(resultsViewModel.scriptures) { scripture in
                                HStack {
                                    TextGradient(text: scripture.location)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                        .foregroundColor(.foregroundBrown)
                                    Spacer()
                                }
                                .padding()
                                .listRowBackground(Color.coffeeBrown.opacity(1))
                                .background(Color.foregroundBrown.opacity(0.1))
                                .cornerRadius(8)
                            }
                        }
                        .listStyle(.plain)
                        .tag(UUID())
                    }
                    .tabViewStyle(PageTabViewStyle())
                }
                .onChange(of: searchText) { _, newValue in
                    if newValue.last == "\n" {
                        resultsViewModel.fetchData(searchText: newValue, searchBy: "verse")
                    }
                }
            }
            .background(Color.coffeeBrown)
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
                .frame(minWidth: 100, minHeight: 500)
                .padding()
            }
        }
        .tabViewStyle(PageTabViewStyle())
        .rotationEffect(.degrees(-270)) // Rotate the TabView
        .frame(width: UIScreen.main.bounds.width) // Set the frame width to the screen width
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
