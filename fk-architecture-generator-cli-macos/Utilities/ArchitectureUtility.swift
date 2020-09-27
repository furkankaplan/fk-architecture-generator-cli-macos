//
//  ArchitectureUtility.swift
//  fk-architecture-generator-cli-macos
//
//  Created by Furkan Kaplan on 27.09.2020.
//

import Foundation

struct ArchitectureUtility {
    
    static func header(isMarkHidden: Bool) -> String {
        return "Created by \(NSFullUserName()) on \(Date().toFormattedDate())\(isMarkHidden ? "." : " with \(AppUtility.name).")"
    }
        
}
