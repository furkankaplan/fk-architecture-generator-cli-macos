//
//  DateExtension.swift
//  fk-architecture-generator-cli-macos
//
//  Created by Furkan Kaplan on 27.09.2020.
//

import Foundation

extension Date {
    
    func toFormattedDate() -> String {
        let format = "dd.MM.yyyy"
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
}
