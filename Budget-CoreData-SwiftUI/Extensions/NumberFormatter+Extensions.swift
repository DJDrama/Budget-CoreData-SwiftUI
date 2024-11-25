//
//  NumberFormatter+Extensions.swift
//  Budget-CoreData-SwiftUI
//
//  Created by Dongjun Lee on 11/25/24.
//

import Foundation

extension NumberFormatter {
    static var currency: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
}
