//
//  AppIntents.swift
//  GoScripture Watch App
//
//  Created by Dylan Price Shade on 9/25/23.
//
import Foundation
import AppIntents

import Foundation
import AppIntents

struct GetScriptureIntent: AppIntent {
    static let title: LocalizedStringResource = "Go get scripture"
    let goScripture = GoScriptureAPI()
    
    @Parameter(title: "Search")
    var search: String?
    
    @Parameter(title: "Verse")
    var verse: String?
    
    func perform() async throws -> some IntentResult & ProvidesDialog & ReturnsValue<String> {
        print("HIT SHORTCUT")
        guard let searchQuery = search else {
            throw $search.needsValueError("What verses would you like to look for?")
        }
        let results = try await goScripture.fetchData(searchText: searchQuery)
        let locations = results.map { $0.location }
        
        if locations.count == 1 {
            return .result(value: locations.first!, dialog: "Found one scripture: \(locations.first!)")
        } else if locations.count > 1 {
            let selectedLocation = try await $search.requestDisambiguation(among: Array(locations.prefix(3)), dialog: "Which scripture would you like to hear?")
            let selectedResult = results.first { $0.location == selectedLocation }
            let verseText = selectedResult?.verse ?? ""
            return .result(value: verseText, dialog: "\(selectedLocation): \(verseText)")
        } else {
            return .result(value: "", dialog: "No scriptures found.")
        }
    }
}

struct GetScriptureShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: GetScriptureIntent(), phrases: ["Search Bible using Go Scripture", "Find Bible verses", ""], shortTitle: "Get Scripture Test", systemImageName: ""
        )
    }
}
