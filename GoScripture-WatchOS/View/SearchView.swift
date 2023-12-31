//
//  SearchView.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//

import SwiftUI

struct SearchView: View {
    @ObservedObject var resultsViewModel: ResultsViewModel
    @Binding var tabSelection: Int
    @Binding var selectedVerse: Int
    
    @State var searchText = ""
    @State var isLoading: Bool = false
    
    var apiClient = GoScriptureAPI()
    
    var body: some View {
        VStack {
            
                Image("Go Scripture")
                    .resizable()
                    .frame(width: 150, height: 30)
                    .padding()

            Spacer()
            TextField("Search God's Word", text: $searchText)
                .padding()
                .foregroundStyle(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(red: 240/255, green: 225/255, blue: 208/255), Color(red: 250/255, green: 245/255, blue: 239/255)]),
                        startPoint: .top,
                        endPoint: .bottomTrailing
                    ))
                .onChange(of: searchText) {
                    if searchText != "" {
                        handleSearchTextChange(searchText: searchText)
                    }
                }
            if searchText != "" && isLoading {
                Text("Finding verses...")
                    .italic()
            }
            Spacer()
            if resultsViewModel.scriptures.count > 0 && !isLoading {
                VStack{
                    Button {
                        searchText = ""
                        resultsViewModel.scriptures = []
                    } label: {
                        Text("Clear")
                            .italic()
                    }
                    .buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
        }
    }
    
    func handleSearchTextChange(searchText: String) {
        
        Task {
            do {
                isLoading = true
                let timer = Timer.scheduledTimer(withTimeInterval: 0.33, repeats: true) { timer in
                    WKInterfaceDevice.current().play(.click)
                }
                resultsViewModel.scriptures = []
                
                let fetchedScriptures = try await apiClient.fetchData(searchText: searchText)
                DispatchQueue.main.async {
                    resultsViewModel.scriptures = fetchedScriptures
                    timer.invalidate()
                    WKInterfaceDevice.current().play(.success)
                    isLoading = false
                    selectedVerse = 0
                    tabSelection = 1
                }
            } catch {
                print("Error: \(error)")
                isLoading = false
            }
        }
    }
}

#Preview {
    SearchView(resultsViewModel: ResultsViewModel(), tabSelection: .constant(1), selectedVerse: .constant(0))
}
