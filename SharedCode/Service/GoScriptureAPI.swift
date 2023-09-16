//
//  GoScriptureAPI.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//


import Foundation

class GoScriptureAPI: ObservableObject {
    @Published var scriptures: [Scripture] = []
    private let baseURL = "http://localhost:3000"

    func fetchData(searchText: String) async throws -> [Scripture] {
        return try await withCheckedThrowingContinuation { continuation in
            let allowedCharacters = CharacterSet.urlQueryAllowed
            guard let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
                continuation.resume(throwing: NSError(domain: "GoScriptureAPI", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error encoding search text"]))
                return
            }

            let urlString = "\(baseURL)/search?query=\(encodedSearchText)"
            guard let url = URL(string: urlString) else {
                continuation.resume(throwing: NSError(domain: "GoScriptureAPI", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                return
            }

            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else if let data = data {
                    do {
                        let fetchedScriptures = try JSONDecoder().decode([Scripture].self, from: data)
                        continuation.resume(returning: fetchedScriptures)
                    } catch {
                        continuation.resume(throwing: error)
                    }
                } else {
                    continuation.resume(throwing: NSError(domain: "GoScriptureAPI", code: 3, userInfo: [NSLocalizedDescriptionKey: "No data and no error"]))
                }
            }
            task.resume()
        }
    }
}
