//
//  RMDateFormatter.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 29.03.2024.
//

import Foundation

import UIKit

final class RMDateFormatter: DateFormattable {
    static let shared = RMDateFormatter()
    let dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    let dateStyle: DateFormatter.Style = .medium
    let timeStyle: DateFormatter.Style = .short
}

// MARK: - Protocol
protocol DateFormattable {
    var dateFormat: String { get }
    var dateStyle: DateFormatter.Style { get }
    var timeStyle: DateFormatter.Style { get }
}

// MARK: - Extension
extension DateFormattable {
    var getValue: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.timeZone = .current
        return formatter
    }
    var setValue: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = dateStyle
        formatter.timeStyle = timeStyle
        return formatter
    }
    func format(from date: String?) -> String {
        guard let date else { return "Unknown date" }
        guard let dateToFormat = getValue.date(from: date)
        else { return "Unknown format" }
        let createdString = setValue.string(from: dateToFormat)
        return createdString
    }
}
