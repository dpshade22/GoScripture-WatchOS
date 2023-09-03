//
//  File.swift
//  GoScripture-WatchOS
//
//  Created by Dylan Price Shade on 9/2/23.
//

import Foundation
import AppIntents

struct GetScriptureShortcut: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: GetScriptureIntent(), phrases: <#T##[AppShortcutPhrase<AppIntent>]#>, shortTitle: <#T##LocalizedStringResource#>, systemImageName: <#T##String#>
    }
}
