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
    var apiClient = GoScriptureAPI()

    func fetchData(searchText: String, searchBy: String) {
        Task {
            do {
                let fetchedScriptures = try await apiClient.fetchData(searchText: searchText, searchBy: searchBy)
                DispatchQueue.main.async {
                    self.scriptures = fetchedScriptures
                }
            } catch {
                print("Error: \(error)")
            }
        }
    }
}
