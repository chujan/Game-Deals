//
//  StringExtension.swift
//  Game Deals
//
//  Created by Jennifer Chukwuemeka on 15/10/2023.
//

import Foundation
extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
