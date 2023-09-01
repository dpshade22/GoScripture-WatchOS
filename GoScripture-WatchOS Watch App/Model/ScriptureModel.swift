//
//  ScriptureModel.swift
//  GoScripture-WatchOS Watch App
//
//  Created by Dylan Price Shade on 8/31/23.
//

import Foundation

struct Scripture: Codable, Hashable, Identifiable {
    var id: Int?
    var index: Int
    var location: String
    var similarities: Double
    var verse: String
}
