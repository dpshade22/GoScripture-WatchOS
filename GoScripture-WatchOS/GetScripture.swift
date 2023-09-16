//
//  GetScripture.swift
//  GoScripture-WatchOS
//
//  Created by Dylan Price Shade on 9/1/23.
//

import Foundation
import AppIntents

enum SearchByOptions: String, Codable {
    case verse = "verse"
    case chapter = "chapter"
    case passage = "passage"
}


@available(iOS 17.0, macOS 14.0, watchOS 10.0, *)
struct GetScripture: AppIntent, WidgetConfigurationIntent, CustomIntentMigratedAppIntent, PredictableIntent {
    static let intentClassName = "GetScriptureIntent"

    static var title: LocalizedStringResource = "Get Scripture"
    static var description = IntentDescription("")

    @Parameter(title: "Search")
    var search: String

    static var parameterSummary: some ParameterSummary {
        Summary("Search the Bible for anything") {
            \.$search
        }
    }
    
    @Parameter(title: "Search By", default: SearchByOptions.verse)
    var searchBy: SearchByOptions?

    static var parameterSummary: some ParameterSummary {
        Summary("Get results as verses, chapters, or passages.") {
            \.$searchBy
        }
    }

    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction(parameters: (\.$search)) { search in
            DisplayRepresentation(
                title: "Search the Bible for anything"
            )
        }
    }

    func perform() async throws -> some IntentResult & ReturnsValue<String> {
        var apiClient = GoScriptureAPI()
        var scriptures: [Scripture] = []
        
        do {
            scriptures = try await apiClient.fetchData(searchText: search, searchBy: searchBy)
        } catch {
            print("Error: \(error)")
        }
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        guard let jsonData = try? encoder.encode(scriptures) else {
            throw NSError(domain: "GetScripture", code: 1, userInfo: [NSLocalizedDescriptionKey: "Error encoding scriptures"])
        }
        
        guard let jsonString = String(data: jsonData, encoding: .utf8) else {
            throw NSError(domain: "GetScripture", code: 2, userInfo: [NSLocalizedDescriptionKey: "Error converting JSON data to string"])
        }
        
        return .result(value: jsonString)
    }
}

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
fileprivate extension IntentDialog {
    static func searchParameterPrompt(search: String) -> Self {
        "What would you like to \(search)?"
    }
    static func searchParameterDisambiguationIntro(count: Int, search: String) -> Self {
        "There are \(count) options matching ‘\(search)’."
    }
    static func searchParameterConfirmation(search: String) -> Self {
        "Just to confirm, you wanted ‘\(search)’?"
    }
}

