//
//  Intent.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 9/1/23.
//

import Foundation
import AppIntents

@available(iOS 17.0, macOS 14.0, watchOS 10.0, *)
struct Intent: AppIntent, WidgetConfigurationIntent, CustomIntentMigratedAppIntent, PredictableIntent {
    static let intentClassName = "IntentIntent"

    static var title: LocalizedStringResource = "Scripture"
    static var description = IntentDescription("")

    @Parameter(title: "Search", default: "Genesis 1:1")
    var search: String?

    static var parameterSummary: some ParameterSummary {
        Summary("Search the Bible for anything") {
            \.$search
        }
    }

    static var predictionConfiguration: some IntentPredictionConfiguration {
        IntentPrediction(parameters: (\.$search)) { search in
            DisplayRepresentation(
                title: "Search the Bible for anything",
                subtitle: ""
            )
        }
    }

    func perform() async throws -> some IntentResult {
        // TODO: Place your refactored intent handler code here.
        return .result()
    }
}

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
fileprivate extension IntentDialog {
    static func searchParameterDisambiguationIntro(count: Int, search: String) -> Self {
        "There are \(count) options matching ‘\(search)’."
    }
    static func searchParameterConfirmation(search: String) -> Self {
        "Just to confirm, you wanted ‘\(search)’?"
    }
}

