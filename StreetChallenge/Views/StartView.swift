//
//  ContentView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 21/03/2022.
//

import SwiftUI
import CoreData

struct StartView: View {
    @State private var startOffset: CGFloat = .zero
    @State private var scale: CGFloat = 1.0
    @State private var showStartButton = false
    @State private var showStartAnimation = true
    
    
    init() {
        UINavigationBar.appearance().tintColor = UIColor(Color.accentColor)
        UINavigationBar.appearance().titleTextAttributes = [ .foregroundColor: UIColor(Color.mainBlack) ]
        UINavigationBar.appearance().largeTitleTextAttributes = [ .foregroundColor: UIColor(Color.mainBlack)]
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(decorative: "anyStreet")
                    .opacity(0.3)
                VStack {
                    Spacer()
                    Spacer()
                    Group {
                        StartLogo()
                            .scaleEffect(scale)
                        StartText()
                    }
                    .offset(x: 0, y: startOffset)
                    .onAppear(perform: {
                        DispatchQueue.main.async {
                            if self.showStartAnimation {
                                withAnimation(.easeInOut(duration: 1.0)) {
                                    startOffset -= startAnimationffset
                                    scale = 0.7
                                }
                            }
                        }
                    })
                    Spacer()
                    NavigationLink(destination: SelectYourCityView()) {
                        Group {
                            if self.showStartButton {
                                CTAButton(label: "Start")
                            }
                        }
                    }
                    Spacer()
                }
                .frame(height: UIScreen.main.bounds.height)
            }
            .font(.largeTitle)
            .shadow(radius: 2.0)
            .onAppear() {
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (_) in
                    DispatchQueue.main.async {
                        withAnimation {
                            self.showStartButton = true
                        }
                    }
                }
            }
            .onDisappear(){
                self.showStartAnimation = false
            }
            
            
        }
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
    }
}

