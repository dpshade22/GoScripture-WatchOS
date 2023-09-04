//
//  ResultsViewModel.swift
//  GoScripture Watch App
//
//  Created by Dylan Price Shade on 9/3/23.
//

import Foundation
import SwiftUI
import Combine

class ResultsViewModel: ObservableObject {
    @Published var scriptures: [Scripture] = []
    @Published var pastSearches: [String: [Scripture]] = [:]
    var apiClient = GoScriptureAPI()

    func fetchData(searchText: String, searchBy: String) {
        // Check if the search text already exists in pastSearches
        if let pastResults = pastSearches[searchText] {
            self.scriptures = pastResults
            return
        }

        Task {
            do {
                let fetchedScriptures = try await apiClient.fetchData(searchText: searchText)
                DispatchQueue.main.async {
                    self.scriptures = fetchedScriptures
                    self.pastSearches[searchText] = fetchedScriptures
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
