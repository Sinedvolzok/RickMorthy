//
//  RMDateFormatter.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 29.03.2024.
//

import Foundation

import UIKit

final class RMDateFormatter {
    private static let getValue: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        formatter.timeZone = .current
        return formatter
    }()
    private static let setValue: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    public class func format(from date: String?) -> String {
        guard let date else { return "Unknown" }
        guard let dateToFormat = Self.getValue.date(from: date) else { return "Unknown" }
        let createdString = Self.setValue.string(from: dateToFormat)
        return createdString
    }
}
