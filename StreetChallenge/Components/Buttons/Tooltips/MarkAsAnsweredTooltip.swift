//
//  MarkAsAnsweredTooltip.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 16/06/2024.
//

import SwiftUI
import TipKit

struct MarkAsAnsweredTooltip: Tip {
    static let alreadyDiscoveredEvent = Event(id: "alreadyDiscoveredEvent")

    var id: String = "MarkAsAnsweredTooltip"
    
    var title: Text {
        Text("Mark as answered")
            .font(.body)
    }

    var message: Text? {
        Text("Done with this question? Mark it as answered!")
            .font(.caption)
    }
    
    var rules: [Rule] {
        [
            #Rule(Self.alreadyDiscoveredEvent) { event in
                event.donations.count <= 1
            },
        ]
    }

    var options: [TipOption] {
        Tips.MaxDisplayCount(1)
    }
}
