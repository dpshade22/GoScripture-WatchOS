//
//  GoScriptureAPI.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//


import Foundation

class GoScriptureAPI: ObservableObject {
    @Published var scriptures: [Scripture] = []
    private let baseURL = "https://go-scripture-l7rxu2v3uq-ul.a.run.app"

    func fetchData(searchText: String, searchBy: String, completion: @escaping (Result<[Scripture], Error>) -> Void) {

            let allowedCharacters = CharacterSet.urlQueryAllowed
            guard let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
                print("Error encoding search text")
                return
            }

            let urlString = "\(baseURL)/search?search_by=\(searchBy)&query=\(encodedSearchText)"
            
        print("Searching by")
        print(searchBy)
            guard let url = URL(string: urlString) else {
                print("Invalid URL")
                return
            }

            print("Fetching data from \(url)")

            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print("Data task error: \(error)")
                    completion(.failure(error))
                } else if let data = data {
                    do {
                        let fetchedScriptures = try JSONDecoder().decode([Scripture].self, from: data)
                        let updatedScriptures = fetchedScriptures.enumerated().map { (index, scripture) -> Scripture in
                                                                                    var updatedScripture = scripture
                                                                                    updatedScripture.id = index
                                                                                    return updatedScripture
                                                                                   }
                       print("Successfully fetched data")
                       completion(.success(updatedScriptures))
                    } catch {
                        print("Decoding error: \(error)")
                        completion(.failure(error))
                    }
                } else {
                    print("No data and no error")
                }
            }
            task.resume()
        }
}
