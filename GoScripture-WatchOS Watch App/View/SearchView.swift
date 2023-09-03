//
//  SearchView.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//

import SwiftUI

struct SearchView: View {
    @Binding var scriptures: [Scripture]
    @State var searchText = ""
    @State var isLoading: Bool = false

    let searchBy: String
    var apiClient = GoScriptureAPI()

    var body: some View {
        NavigationView {
            VStack {
                if searchText != "" {
                    Text(isLoading ? "Finding verse..." : "Verses found...")
                        .italic()
                        .padding()
                }
            }
            .searchable(text: $searchText, prompt: "Search God's Word")
        }
        .onChange(of: searchText) {
            handleSearchTextChange(searchText: searchText)
        }
    }

    func handleSearchTextChange(searchText: String) {
        isLoading = true
        Task {
            do {
                let fetchedScriptures = try await apiClient.fetchData(searchText: searchText, searchBy: searchBy)
                DispatchQueue.main.async {
                    scriptures = fetchedScriptures
                    print(scriptures)
                    WKInterfaceDevice.current().play(.success)
                    isLoading = false
                }
            } catch {
                print("Error: \(error)")
                isLoading = false
            }
        }
    }
}

#Preview {
    SearchView(scriptures: .constant([]), searchBy: "Verse")
}
