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
            NavigationView{
                VStack {
                    if searchText != ""{
                        Text(isLoading ?  "Finding verse..." : "Verses found...")
                            .italic()
                            .padding()
                    }
                }
                .searchable(text: $searchText, prompt: searchBy)
            }
            .onChange(of: searchText) {
                isLoading = true
                apiClient.fetchData(searchText: searchText, searchBy: searchBy) { result in
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let fetchedScriptures):
                            scriptures = fetchedScriptures
                            print(scriptures)
                            WKInterfaceDevice.current().play(.success)
                        case .failure(let error):
                            print("Error: \(error)")
                        }
                        isLoading = false
                    }
            }
        }
    }

}

#Preview {
    SearchView(scriptures: .constant([]), searchBy: "Verse")
}
