//
//  UIAplication.swift
//  RickMorthy
//
//  Created by Denis Kozlov on 12.04.2024.
//

import UIKit

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
