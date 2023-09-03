//
//  IntentHandler.swift
//  GoScripture-WatchOS-Intents
//
//  Created by Dylan Price Shade on 9/1/23.
//

import AppIntents

struct GetScriptureIntent: AppIntent {
    static let title: LocalizedStringResource = "Get scripture for your search"
    var apiClient = GoScriptureAPI()
    
    
    func perform() async throws -> some IntentResult {
        await apiClient.fetchData(searchText: "Testing", searchBy: "verse")
        return .result(value: <#T##_IntentValue#>)
    }
}
