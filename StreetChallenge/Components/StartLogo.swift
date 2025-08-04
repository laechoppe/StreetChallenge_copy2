//
//  StartLogo.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 27/03/2022.
//

import SwiftUI

struct StartLogo: View {
    @State private var scale: Double  = 1.0
    @State private var offset: Double = 0.0
    @State private var showStartAnimation = true
    
    var body: some View {
        Image("appstore_logo")
            .resizable()
            .frame(minWidth: 50, idealWidth: 100, maxWidth: 200, minHeight: 50, idealHeight: 100, maxHeight: 200, alignment: .center)
    }
}

struct StartLogo_Previews: PreviewProvider {
    static var previews: some View {
        StartLogo()
    }
}
