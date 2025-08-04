//
//  Constants.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 27/03/2022.
//

import Foundation
import SwiftUI

let startAnimationffset: CGFloat = 200

let terms: String = """
When using the app, please be aware of your surroundings. London has some very busy roads. Take care, use pedestrian crossings, and be sensible!

By using the app you agree that neither Street Challenge nor any person associated with us will be liable to you or any other participant for any direct or indirect damages that arise in any way. You agree to communicate this liability to any person that you invite to participate.

All users are strictly prohibited from sharing or disclosing any questions, answers, guides, or related content from the app or website offline or on any online platform or social media channels. Sharing such information could diminish the experience for other participants and is a violation of the terms of use.

All content included on this app and website and information we send to you, including questions, answers, comments, guides and hints is copyright of Street Challenge.
"""

let privacy: String = """
Thank you for using Street Challenge. Your privacy is crucial to us, and we are committed to safeguarding any information you share with us. This Privacy Policy outlines how we collect, use, and protect data within our app.

*Information Collection*
We do not collect, store, or process any personal data from our users. Our app functions without requiring or accessing any personal information such as names, email addresses, phone numbers, or any identifiable data.

*Usage of Information*
As we do not gather any personal information, there is no usage of such data. Your privacy and anonymity remain intact while using our app.

*Data Security*
While there is no user data collected, stored, or processed, we employ industry-standard security measures to protect the app and its functionalities.

*Third-Party Services*
Our app may link to third-party services or websites. Please note that this Privacy Policy applies solely to our app, and we do not control the privacy policies or practices of any third-party services.

*Children's Privacy*
Our app does not target or collect any information from individuals under the age of 13 knowingly. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us, and we will take appropriate action to remove such data.

*Changes to Privacy Policy*
We reserve the right to modify or update this Privacy Policy at any time. Any changes made will be effective upon posting the revised Privacy Policy within the app.

*Contact Us*
If you have any questions or concerns regarding this Privacy Policy or our app's practices, please contact us at your-email@example.com
"""
let onboarding: String = """
**Welcome to Street Challenge!**

Ready to explore some hidden gems?

Check out cool spots, solve fun challenges, and discover the city like never before.
"""

let rules: String = """
Answer the question to uncover the hidden location. Use any sources or just explore — whatever works! Pay attention to odd words or phrases; they could be clues.

Once there, take a moment to enjoy the spot. Good luck!
"""

let buttons: String = """
\(Image(systemName: "map")) - see map for the area
\(Image(systemName: "xmark")) - mark question as answered. Tap again to remove
"""

struct Constants {
    /*
     The API key for app from the RevenueCat dashboard: https://app.revenuecat.com
     */

    static var apiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "RevenueCatAPIKey") as? String else {
            print("RevenueCat API key not found in Info.plist")
            return ""
        }
        return apiKey
    }

    /*
     The entitlement ID from the RevenueCat dashboard that is activated upon successful in-app purchase for the duration of the purchase.
     */
    static let entitlementID = "premium"

    static let paymentTerms = """
By making a one-time in-app purchase in Street Challenge app, you gain lifetime access to Premium question packs and challenges, and guides.

All other terms, including payment processing, refunds, and use of the App, are governed by Apple's End User License Agreement (EULA), which can be reviewed at https://www.apple.com/legal/internet-services/itunes/dev/stdeula/.

For any questions, contact us at your-email@example.com.
"""
}
