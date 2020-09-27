//
//  ArchitectureUtility.swift
//  fk-architecture-generator-cli-macos
//
//  Created by Furkan Kaplan on 27.09.2020.
//

import Foundation

struct ArchitectureUtility {
    
    static var header: String {
        return "Created by \(NSFullUserName()) on \(Date().toFormattedDate()) with \(AppUtility.name)."
    }
    
}
