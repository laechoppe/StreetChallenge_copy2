//
//  Answer.swift
//  StreetChallenge
//
//  Created by Uladzislau Ramanenka on 19/12/2023.
//

import Foundation

struct Answer: Identifiable, Hashable, Codable {
    var id: String
    var questionId: String
    var userId: String
    var answerText: String
}
