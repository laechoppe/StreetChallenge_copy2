//
//  RulesView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 19/06/2022.
//

import SwiftUI

struct RulesButton: View {
    @State private var showRules = false
    
    var body: some View {
        Button(action: {
            self.showRules = true
        }, label: {
            Image(systemName: "questionmark.circle").foregroundColor(.mainBlack).font(.body)
        })
        .sheet(isPresented: $showRules, content: {
            SettingsView()
        })
    }
}

struct RulesButton_Previews: PreviewProvider {
    static var previews: some View {
        RulesButton()
    }
}
