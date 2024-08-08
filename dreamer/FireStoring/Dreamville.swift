//
//  Dream.swift
//  dreamer
//
//  Created by Kody Chik on 2024-08-07.
//

import Foundation

struct Dreamville: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var date: String
    var dream: String
    var analysis: String
}
