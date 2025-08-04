//
//  RulesView.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 19/06/2022.
//

import SwiftUI

struct SettingsView: View {
    @State private var showingTermsPopover = false
    @State private var showingPrivacyPopover = false
    @State private var paywallPresented = false
    @Environment(UserViewModel.self) private var userModel: UserViewModel

    private var explanation  = "**Street Challenge** is your city exploration guide! Discover hidden gems, learn fascinating stories, and answer questions as you explore your way."

    var body: some View {
        VStack {
            Spacer()
            Text(.init(explanation))
                .multilineTextAlignment(.center)
                .padding()
            ZStack {
                List {
                    Button(action: {
                        self.paywallPresented = true
                    }, label: {
                        HStack{
                            Image(systemName: "sparkle")
                            Text("Buy Premium")
                        }
                        .foregroundStyle(Color.mainRed)
                    })
                    .disabled(userModel.subscriptionActive)
                    .opacity(!userModel.subscriptionActive ? 1 : 0.5)
                    Section() {
                        Button("Terms & Conditions", action: {
                            self.showingTermsPopover = true
                        })
                        Button("Privacy Policy", action: {
                            self.showingPrivacyPopover = true
                        })
                    }
                    Section() {
                        HStack {
                            Button(action: {
                                let emailformatted = "mailto:your-email@example.com"
                                guard let url = URL(string: emailformatted) else { return }
                                UIApplication.shared.open(url)
                            }) {
                                Image(systemName: "envelope.circle.fill")
                            }
                            Text("Contact")
                        }
                        HStack {
                            Button(action: {
                                let appId = "6504174138"
                                guard let url = URL(string: "itms-apps:itunes.apple.com/us/app/apple-store/id\(appId)?mt=8&action=write-review") else { return }
                                UIApplication.shared.open(url)
                            }) {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                            }
                            Text("Rate us")
                        }
                    }


                    Section(){
                        Text("v \(Bundle.main.appVersionLong) - 05.2025")
                    }
                    Text(.init(Bundle.main.copyright))
                        .font(.caption)
                }
                .sheet(isPresented: $showingPrivacyPopover, content: {
                    PrivacyPolicyView()
                })
                .sheet(isPresented: $showingTermsPopover, content: {
                    TermsView()
                })
                .sheet(isPresented: $paywallPresented, content: {
                    PaywallView(isPresented: $paywallPresented)
                })
            }
        }
    }
}

struct RulesView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

extension Bundle {
    public var appName: String           { getInfo("CFBundleName") }
    public var displayName: String       { getInfo("CFBundleDisplayName") }
    public var language: String          { getInfo("CFBundleDevelopmentRegion") }
    public var identifier: String        { getInfo("CFBundleIdentifier") }
    public var copyright: String         { getInfo("NSHumanReadableCopyright").replacingOccurrences(of: "\\n", with: "\n") }

    public var appBuild: String          { getInfo("CFBundleVersion") }
    public var appVersionLong: String    { getInfo("CFBundleShortVersionString") }

    fileprivate func getInfo(_ str: String) -> String { infoDictionary?[str] as? String ?? "⚠️" }
}
